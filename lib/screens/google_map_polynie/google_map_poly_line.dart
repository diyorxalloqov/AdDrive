import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:addrive/controller/location_controller.dart';
import 'package:addrive/map_style/util.dart';
import 'package:addrive/model/daily_tracking_model.dart';
import 'package:addrive/controller/polyline_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double cameraZoom = 16;
const double cameraTilt = 0;
const double cameraBearing = 30;
const LatLng sourceLocation = LatLng(23.779394, 90.376844);
const LatLng destLocation = LatLng(23.749394, 90.356844);

class MapPolylinePage extends StatefulWidget {
  const MapPolylinePage({Key? key}) : super(key: key);

  // final LatLng source;
  // final LatLng destination;
  //
  //
  // MapPolylinePage({@required this.source,@required this.destination});
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPolylinePage> {
  final Completer<GoogleMapController> _controller = Completer();

  // this set will hold my markers
  final Set<Marker> _markers = {};

  // this will hold the generated polylines
  final Set<Polyline> _polyLines = {};

  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];

  //list of way
  List<PolylineWayPoint> polylineWayPoints = [];

  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyDqis34l3OudHBfSdHEkQY1_erRXub9vLE";

  // for my custom icons
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      print(sourceLocation.toString());
      print(destLocation.toString());
    }
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        'asset/icons/markers/location_marker.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        'asset/icons/markers/location_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    PolylineController locationDataController = Get.put(PolylineController());
    LocationController locationServiceController = Get.find();

    CameraPosition initialLocation = CameraPosition(
        zoom: cameraZoom,
        bearing: cameraBearing,
        tilt: cameraTilt,
        target: LatLng(
            locationServiceController.userLocation.value?.latitude ?? 0.0,
            locationServiceController.userLocation.value?.longitude ?? 0.0));

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('driving_route'.tr,style: const TextStyle(color: Colors.white),),
        ),
        body: locationDataController.isLoading.isFalse
            ? Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: false,
                    markers: _markers,
                    polylines: _polyLines,
                    mapType: MapType.normal,
                    initialCameraPosition: locationDataController.initialLocation ?? initialLocation,
                    onMapCreated: (controller) => onMapCreated(
                        controller, locationDataController.latLongData),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('travel_history'.tr, style: Get.textTheme.headlineMedium,),),
                              const Icon(Icons.map)
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'from'.tr,
                                style: Get.textTheme.bodyLarge,
                              ),
                              locationDataController.dailyTackingDetails.value
                                          ?.geoLocation?.isNotEmpty ==
                                      true
                                  ? Text(
                                      '${locationDataController.dailyTackingDetails.value?.geoLocation?[0].start}')
                                  : const Text('N/A'),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'to'.tr,
                                style: Get.textTheme.bodyLarge,
                              ),
                              locationDataController.dailyTackingDetails.value
                                          ?.geoLocation?.isNotEmpty ==
                                      true
                                  ? Text(
                                      '${locationDataController.dailyTackingDetails.value?.geoLocation?[1].end}',
                                      style: Get.textTheme.bodyMedium,
                                    )
                                  : const Text('N/A'),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'distance'.tr,
                                    style: Get.textTheme.bodyLarge
                                        ?.copyWith(height: 1.4),
                                  ),
                                  Wrap(
                                      spacing: 4,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      children: [
                                        Text(locationDataController
                                                .dailyTackingDetails
                                                .value
                                                ?.distance ??
                                            'N/A'),
                                        Text(
                                          'KM',
                                          style: Get.textTheme.bodySmall,
                                        )
                                      ]),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('date_time'.tr, style: Get.textTheme.bodyLarge?.copyWith(height: 1.4),),
                                  Text(locationDataController.dailyTackingDetails.value?.startTime ?? 'N/A'),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : const Center(child: CircularProgressIndicator(),),
      ),
    );
  }

  void onMapCreated(
      GoogleMapController controller, List<DailyTrackingList> list) {
    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    if (list.length > 1) {
      ///first point as origin
      final first =
          LatLng(list.first.latitude ?? 0.0, list.first.longitude ?? 0.0);

      ///last point as destination
      final last =
          LatLng(list.last.latitude ?? 0.0, list.last.longitude ?? 0.0);

      setMapPins(first, last);
      // setPolylines(middle, last);
      list.sublist(0, list.length > 8 ? 7 : list.length).forEach((point) {
        final index = list.indexOf(point);

        if (index < list.length - 1) {
          // final point1 = LatLng(point.latitude, point.longitude);
          // final point2 = LatLng(list.elementAt(index + 1).latitude, list.elementAt(index + 1).longitude);
          //
          // setPolylines(point1, point2);
          polylineWayPoints.add(PolylineWayPoint(
              location: '${point.latitude},${point.longitude}'));
        }
      });
      setPolyLines(first, last);
    }
  }

  void setMapPins(LatLng source, LatLng destination) {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: const MarkerId('sourcePin'),
          position: source,
          icon: sourceIcon!));
      // destination pin
      _markers.add(Marker(
          markerId: const MarkerId('destPin'),
          position: destination,
          icon: destinationIcon!));
    });
  }

  setPolyLines(LatLng? source, LatLng? destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(source?.latitude ?? 0.0, source?.longitude ?? 0),
        PointLatLng(destination?.latitude ?? 0.0, destination?.longitude ?? 0),
        optimizeWaypoints: true,
        wayPoints: polylineWayPoints,
        travelMode: TravelMode.driving);

    for (var point in result.points) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: const PolylineId("poly"),
          color: Colors.red,
          width: 4,
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polyLines.add(polyline);
    });
  }
}
