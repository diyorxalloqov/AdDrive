import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:addrive/app_config/custom_styles.dart';
import 'package:addrive/map_style/util.dart';
import 'package:addrive/model/driver_location_model.dart';
import 'package:addrive/model/user_location.dart';
import 'package:addrive/model/user_profile.dart';
import 'package:addrive/services/firebase_location_service.dart';
import 'package:addrive/services/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OwnerDriverScreen extends StatefulWidget {
  final UserProfile driverProfile;

  const OwnerDriverScreen({super.key, required this.driverProfile});

  @override
  OwnerDriverScreenState createState() => OwnerDriverScreenState();
}

class OwnerDriverScreenState extends State<OwnerDriverScreen> {
  GoogleMapController? _controller;
  BitmapDescriptor? carIcon;

  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<UserLocation>(context);
    final firebaseLocationService =
        Provider.of<FirebaseLocationService>(context);
    final position = Provider.of<Position>(context);
    carIcon = Provider.of<BitmapDescriptor>(context);
    return Scaffold(
      body: Center(
              child: _buildList(currentLocation, firebaseLocationService,
                  widget.driverProfile,position),
            ),
    );
  }

  Widget _buildList(UserLocation userLocation, FirebaseLocationService service,
      UserProfile? driverProfile,Position position) {
    return SafeArea(
      child: StreamBuilder<DriverLocationModel?>(
        stream: service.getDriverData(did: driverProfile?.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DriverLocationModel? model = snapshot.data;

            //continuously update camera position after 2 seconds
            Timer(const Duration(seconds: 2), () {
              _controller?.moveCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(model?.latitude ?? 0.0, model?.longitude ?? 0.0),
                      zoom: 18.0)));
            });

            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FractionallySizedBox(
                  heightFactor: 0.90,
                  alignment: Alignment.topCenter,
                  child: GoogleMap(
                    onMapCreated: (controller) => _onMapCreated(controller, model!),
                    initialCameraPosition: CameraPosition(
                        target: LatLng(model?.latitude ?? 0.0, model?.longitude ?? 0.0),
                        zoom: 18.0),
                    mapType: MapType.normal,
                    markers: {
                      Marker(
                        markerId: const MarkerId('marker_id'),
                        position: LatLng(model?.latitude ?? 0.0, model?.longitude ?? 0.0),
                        icon: carIcon!,
                        rotation: model?.heading != null ?  model?.heading ?? 0.0 * cos(60.0):0.0,
                        infoWindow: InfoWindow(title: model?.address),
                      ),
                    },
                    myLocationEnabled: true,
                  ),
                ),
                DraggableScrollableSheet(
                    initialChildSize: 0.1,
                    minChildSize: 0.1,
                    maxChildSize: 0.8,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return FutureBuilder<List<geocoding.Placemark>?>(
                        future: GeoLocatorService().getAddress(position),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0)),
                                color: Colors.grey[200],
                              ),
                              child: ListView(
                                controller: scrollController,
                                children: <Widget>[
                                  const ListTile(
                                    title: Text(
                                      'Driver position',
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: CustomStyles.boxShadow,
                                    ),
                                    child: ListTile(
                                      leading: const Text('Speed'),
                                      trailing: Text(
                                          '${(model?.speed == null ? 0 : model?.speed ?? 0.0 / 36000).toStringAsFixed(2)} km/h'),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: CustomStyles.boxShadow,
                                    ),
                                    child: ListTile(
                                      leading: const Text('City'),
                                      trailing: Text(model?.city ?? ''),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: CustomStyles.boxShadow,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        const Text('Address'),
                                        const SizedBox(width: 8.0,),
                                        Expanded(child: Text(model?.address ?? '',maxLines: 2,)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: CustomStyles.boxShadow,
                                    ),
                                    child: ListTile(
                                      leading: const Text('Country'),
                                      trailing: Image.network('https://www.countryflags.io/${model?.countryCode != null ?  model?.countryCode!.toLowerCase() : 0}/flat/32.png'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text('Loading...'),
                            );
                          }
                        },
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

  _onMapCreated(GoogleMapController controller, DriverLocationModel model) {
    _controller = controller;
    _controller?.setMapStyle(Utils.mapStyles);
  }
}
