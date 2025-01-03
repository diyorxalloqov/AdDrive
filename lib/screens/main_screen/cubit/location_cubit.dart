/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:addrive/utils/enums/status.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    hide PermissionStatus;

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  final Location location = Location();
  StreamSubscription? _locationSubscription;
  Timer? _locationStatusTimer;

  void listenLocation() {
    location.requestPermission().asStream().listen((status) {
      if (status == PermissionStatus.granted) {
        emit(state.copyWith(locationStatus: ActionStatus.isLoading));
        Future.delayed(const Duration(seconds: 2)).then((e) =>
            emit(state.copyWith(locationStatus: ActionStatus.isSuccess)));
        _checkLocationStatus();
      } else if (status == PermissionStatus.deniedForever) {
        openAppSettings();
        emit(state.copyWith(locationStatus: ActionStatus.isError));
      } else {
        emit(state.copyWith(locationStatus: ActionStatus.isError));
      }
    });
  }

  void _checkLocationStatus() {
    // Periodically check if location services are enabled
    _locationStatusTimer =
        Timer.periodic(const Duration(seconds: 5), (timer) async {
      final isServiceEnabled = await location.serviceEnabled();
      if (!isServiceEnabled) {
        emit(state.copyWith(locationStatus: ActionStatus.isError));
      } else if (state.locationStatus != ActionStatus.isSuccess) {
        emit(state.copyWith(locationStatus: ActionStatus.isLoading));
        Future.delayed(const Duration(seconds: 2)).then((e) =>
            emit(state.copyWith(locationStatus: ActionStatus.isSuccess)));
      }
    });

    // Optional: Listen to location changes if you want to do something specific
    _locationSubscription = location.onLocationChanged.listen((locationData) {
      // Handle location updates here if needed
    });
  }

  @override
  Future<void> close() {
    // Clean up timers and subscriptions
    _locationSubscription?.cancel();
    _locationStatusTimer?.cancel();
    return super.close();
  }
}
