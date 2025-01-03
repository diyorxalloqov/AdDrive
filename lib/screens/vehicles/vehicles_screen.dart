import 'package:addrive/controller/vehicles_list_controller.dart';
import 'package:addrive/global/imports/app_imports.dart';
import 'package:addrive/global/widgets/decoration_widget.dart';
import 'package:addrive/model/vehicle_list_model.dart';
import 'package:addrive/widgets/error_screen.dart';
import 'package:addrive/widgets/no_data_found_widget.dart';

class VehiclesScreen extends StatelessWidget {
  final controller = Get.put(VehicleListController());
  final bool? isBottomNavbar;
  VehiclesScreen({super.key, this.isBottomNavbar});
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle =
        context.theme.textTheme.labelMedium?.copyWith(fontSize: 14);
    return Scaffold(
        appBar: isBottomNavbar != null
            ? null
            : AppBarWidget(titleText: 'vehicles'.tr, centerTitle: true),
        body: controller.obx(
          (state) => state?.data?.isNotEmpty == true
              ? ListView.builder(
                  itemCount: state?.data?.length ?? 0,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (BuildContext context, int index) {
                    final data = state?.data?[index];
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          decoration: decoration(context),
                          margin: const EdgeInsets.only(top: 40),
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 80, left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${data?.vehicleName}',
                                    style: context.theme.textTheme.labelMedium),
                                const SpaceHeight(height: 24),

                                /// Mileage mpg and year
                                buildMialeageMpgYear(data!, context),

                                /// Brand, displacement and engine
                                buildBrandDisplacementEngine(data, context),

                                /// Abs, Model, HP
                                buildAbsModelHp(data, context),

                                /// All permission status
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('fitness'.tr, style: textStyle),
                                    const SpaceWidth(width: 10),
                                    Flexible(
                                      child: Text(
                                        '${data.fitness}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context
                                            .theme.textTheme.headlineSmall
                                            ?.copyWith(
                                                color: data.fitness
                                                            ?.contains('Yes') ==
                                                        true
                                                    ? Colors.green
                                                    : Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                                const SpaceHeight(height: 8),
                                buildColumn(data, context),
                                const SpaceHeight(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('license'.tr, style: textStyle),
                                    const SpaceWidth(width: 16),
                                    Flexible(
                                      child: Text(
                                        data.license ?? 'N/A',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context
                                            .theme.textTheme.headlineSmall
                                            ?.copyWith(
                                                color: data.license!
                                                        .contains('Yes')
                                                    ? Colors.green
                                                    : Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                                const SpaceHeight(height: 20),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage('${data.carImage}')))
                      ],
                    );
                  })
              : const NoDataFoundWidget(),
          onEmpty: ErrorScreen(
            title: 'No Vehicle found',
            subTitle: 'Add your vehicle',
            onPressed: () async {
              await controller.getVehicleListData();
            },
          ),
          // onError: (error) => Text(error)
        ));
  }

  Column buildAbsModelHp(Datum data, BuildContext context) {
    TextStyle? textStyle =
        context.theme.textTheme.labelMedium?.copyWith(fontSize: 14);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ABS', style: textStyle),
            const SpaceWidth(width: 16),
            Flexible(
              child: Text(
                data.abs ?? 'N/A',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SpaceHeight(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('model'.tr, style: textStyle),
            const SpaceWidth(width: 16),
            Flexible(
              child: Text(
                data.vehicleModel ?? 'N/A',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SpaceHeight(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('HP', style: textStyle),
            const SpaceWidth(width: 16),
            Flexible(
              child: Text(
                data.horsePower ?? 'N/A',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SpaceHeight(height: 6),
        Divider(color: context.theme.colorScheme.onPrimary.withOpacity(0.2)),
        const SpaceHeight(height: 10)
      ],
    );
  }

  Column buildBrandDisplacementEngine(Datum data, BuildContext context) {
    TextStyle? textStyle =
        context.theme.textTheme.labelMedium?.copyWith(fontSize: 14);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('brand'.tr, style: textStyle),
            const SpaceWidth(width: 16),
            Flexible(
              child: Text(
                '${data.vehicleName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SpaceHeight(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('displacement'.tr,
                textAlign: TextAlign.start, maxLines: 1, style: textStyle),
            const SpaceWidth(width: 16),
            Flexible(
              child: Text(
                '${data.displacement}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SpaceHeight(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('engine'.tr, style: textStyle),
            const SpaceWidth(width: 16),
            Flexible(
              child: Text(data.engine ?? 'N/A',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.headlineSmall),
            ),
          ],
        ),
        const SpaceHeight(height: 6),
        Divider(color: context.theme.colorScheme.onPrimary.withOpacity(0.2)),
        const SpaceHeight(height: 10)
      ],
    );
  }

  Column buildMialeageMpgYear(Datum data, BuildContext context) {
    TextStyle? textStyle =
        context.theme.textTheme.labelMedium?.copyWith(fontSize: 14);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('mileage'.tr, style: textStyle),
            const SpaceWidth(width: 16),
            Flexible(
              child: Text(
                '${data.mileage}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SpaceHeight(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('MPG', style: textStyle),
            const SpaceWidth(width: 10),
            Text(
              '${data.mpg}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.headlineSmall,
            ),
          ],
        ),
        const SpaceHeight(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('year'.tr, style: textStyle),
            const SpaceWidth(width: 10),
            Text('${data.vehicleMakeYear}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.headlineSmall),
          ],
        ),
        const SpaceHeight(height: 6),
        Divider(color: context.theme.colorScheme.onPrimary.withOpacity(0.2)),
        const SpaceHeight(height: 10)
      ],
    );
  }

  Row buildColumn(Datum data, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('route_permit'.tr,
            textAlign: TextAlign.start,
            style: context.theme.textTheme.labelMedium?.copyWith(fontSize: 14)),
        const SpaceWidth(width: 10),
        Flexible(
          child: Text(
            data.routePermit ?? 'N/A',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.headlineSmall?.copyWith(
              color:
                  data.routePermit!.contains('Yes') ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
