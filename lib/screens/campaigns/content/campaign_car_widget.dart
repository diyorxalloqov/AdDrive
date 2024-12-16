import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/hive/hive_fav_provider.dart';
import 'package:flutter_texi_tracker/model/campaignListModel.dart';
import 'package:flutter_texi_tracker/model/hive_model/fav/favourite_car_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';

class CampaignCarWidget extends StatelessWidget {
  final Campaign? campaign;
  final Function()? onTap;
  final String? joinStatus;

  const CampaignCarWidget(
      {super.key, required this.campaign, this.onTap, this.joinStatus});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          height: 170.0,
          width: double.infinity,
          fit: BoxFit.cover,
          imageUrl: campaign?.brandImage ?? "",
          placeholder: (context, url) => Center(
            child: Image.asset("asset/logo/adgari_logo_main.png"),
          ),
          errorWidget: (context, url, error) => Image.asset(
            "asset/logo/adgari_logo_main.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                campaign?.name ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Location: ${campaign?.location ?? ""}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Branding type: ${campaign?.type ?? ""}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Duration:${campaign?.duration ?? ""}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "NGN ${campaign?.amount ?? ""}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 14),
                      decoration: BoxDecoration(
                          color: joinStatus == 'join'
                              ? Colors.deepOrangeAccent
                              : Colors.green,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                      child: Text(
                        joinStatus ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: [
                        Consumer<FavService>(
                            builder: (context, favProvider, _) {
                          return InkWell(
                              onTap: () {
                                final isAlreadyInFav = favProvider
                                    .isCarAlreadyInFavList(campaign?.id ?? 0);
                                if (!isAlreadyInFav) {
                                  final favProduct = FavoriteCar(
                                      id: campaign?.id,
                                      brandName: campaign?.name ?? "",
                                      brandingType: campaign?.type ?? "",
                                      location: campaign?.location ?? "",
                                      duration: campaign?.duration ?? "",
                                      price: campaign?.amount ?? "",
                                      image: campaign?.brandImage ?? "");
                                  favProvider.addCarToFavList(favProduct);
                                } else {
                                  favProvider.removeCarToFavListById(
                                      id: campaign?.id ?? 0);
                                }
                              },
                              child: Icon(Icons.favorite,
                                  color: favProvider.isCarAlreadyInFavList(
                                          campaign?.id ?? 0)
                                      ? Colors.red
                                      : Colors.grey));
                        }),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                            onTap: () async {
                              await Share.share("Share Data");
                            },
                            child: const Icon(
                              Icons.share,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              const Divider(),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }
}
