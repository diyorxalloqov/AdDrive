import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:addrive/hive/hive_fav_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:addrive/widgets/no_data_found_widget.dart';
import 'package:provider/provider.dart';
import '../../model/hive_model/fav/favourite_car_model.dart';

class CampaignFavListScreen extends StatelessWidget {
  const CampaignFavListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavService>(builder: (context, favProvider, _) {
      final data = favProvider.getAllFavCar();
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                data.isNotEmpty
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.4),
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 1.0,
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          height: 150.0,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          imageUrl: data[index].image ?? "",
                                          placeholder: (context, url) => Center(
                                            child: Image.asset(
                                                "asset/logo/adgari_logo_main.png"),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            "asset/logo/adgari_logo_main.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 12,
                                          top: 8,
                                          child: InkWell(
                                              onTap: () {
                                                final isAlreadyInFav =
                                                    favProvider
                                                        .isCarAlreadyInFavList(
                                                            data[index].id!);
                                                if (!isAlreadyInFav) {
                                                  final favCar = FavoriteCar(
                                                    id: data[index].id,
                                                    brandName:
                                                        data[index].brandName,
                                                    brandingType: data[index]
                                                        .brandingType,
                                                    image: data[index].image,
                                                    price: data[index].price,
                                                  );
                                                  favProvider
                                                      .addCarToFavList(favCar);
                                                } else {
                                                  favProvider
                                                      .removeCarToFavListById(
                                                          id: data[index].id!);
                                                }
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: favProvider
                                                        .isCarAlreadyInFavList(
                                                            data[index].id!)
                                                    ? Colors.red
                                                    : Colors.white,
                                                size: 24.sp,
                                              )))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data[index].brandName} ${data[index].id}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data[index].duration ?? "",
                                        style: const TextStyle(
                                            color: Colors.black38,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${data[index].price ?? ""}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                    : const NoDataFoundWidget()
              ],
            ),
          ),
        ),
      );
    });
  }
}
