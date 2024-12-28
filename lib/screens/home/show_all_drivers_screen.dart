import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/map_style/util.dart';
import 'package:flutter_texi_tracker/model/driver_location_model.dart';
import 'package:flutter_texi_tracker/model/user_location.dart';
import 'package:flutter_texi_tracker/model/user_profile.dart';
import 'package:flutter_texi_tracker/services/firebase_location_service.dart';
import 'package:flutter_texi_tracker/services/marker_service.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ShowAllDriversInMapScreen extends StatefulWidget {
  ///list of driver profile
  final List<UserProfile>? driverProfiles;

  ///icon for map
  final PlacemarkIcon? iconDescriptor;

  ///firebase location service for
  ///getting driver data
  final FirebaseLocationService? firebaseLocationService;

  const ShowAllDriversInMapScreen(
      {super.key, this.driverProfiles, this.iconDescriptor, this.firebaseLocationService});

  @override
  ShowAllDriversInMapScreenState createState() =>
      ShowAllDriversInMapScreenState();
}

class ShowAllDriversInMapScreenState extends State<ShowAllDriversInMapScreen> {
  late YandexMapController _controller;
  List<DriverLocationModel> driversInfo = [];

  @override
  Widget build(BuildContext context) {
    ///current user Location=>customized
    final currentLocation = Provider.of<UserLocation>(context);

    // ///current user position=> package
    // final position = Provider.of<Position>(context);

    ///marker service for getting driver marker
    final markerService = MarkerService();
    return Scaffold(
      body:Center(
              child: _buildList(currentLocation, widget.firebaseLocationService!, widget.driverProfiles!, markerService),
            ),
    );
  }

  Widget _buildList(
      UserLocation userLocation,
      FirebaseLocationService locationService,
      List<UserProfile> driverProfiles,
      MarkerService markerService) {
    final markers = markerService.getMarkers(
            carBitMapDescriptor: widget.iconDescriptor,
            locationService: locationService,
            profiles: driverProfiles,
            getDrivers: (drivers) {
              driversInfo = drivers;
            });
    return SafeArea(
      child: FutureBuilder<List<PlacemarkMapObject>>(
        future: markers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FractionallySizedBox(
                  heightFactor: 0.90,
                  alignment: Alignment.topCenter,
                  child: YandexMap(
                    onMapCreated: (controller) => _onMapCreated(controller),
                    // initialCameraPosition: CameraPosition(
                    //     target: Point(
                    //        latitude:  userLocation.latitude,longitude:  userLocation.longitude),
                    //     zoom: 18.0),
                    mapType: MapType.satellite,
                    // markers: Set<Marker>.of(snapshot.data!),
                    // myLocationEnabled: true,
                    //
                  ),
                ),
                DraggableScrollableSheet(
                    initialChildSize: 0.1,
                    minChildSize: 0.1,
                    maxChildSize: 0.8,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          color: Colors.grey[200],
                        ),
                        child: ListView.separated(
                          controller: scrollController,
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: driversInfo.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                _controller.moveCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: Point(
                                               latitude:  driversInfo.elementAt(index).latitude ?? 0.0,
                                                longitude:  driversInfo.elementAt(index).longitude ?? 0.0) ,
                                            zoom: 18.0)));
                              },
                              title: Text(
                                  '${driverProfiles.elementAt(index).name}',style: Theme.of(context).textTheme.titleMedium,),
                              subtitle: Text(
                                  driversInfo.elementAt(index).address ?? ' ${driversInfo.elementAt(index).city}'),
                            );
                          },
                        ),
                      );
                    }),
              ],
            );
          } else {
            return const Center(
              child: Text('Data loading...'),
            );
          }
        },
      ),
    );
  }

  _onMapCreated(YandexMapController controller) {
    _controller = controller;
    _controller.setMapStyle(Utils.mapStyles);
  }
}
