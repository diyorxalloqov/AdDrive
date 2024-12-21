/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

part of 'location_cubit.dart';

class LocationState extends Equatable {
  final ActionStatus locationStatus;
  const LocationState({
    this.locationStatus = ActionStatus.isInitial,
  });

  LocationState copyWith({ActionStatus? locationStatus}) {
    return LocationState(locationStatus: locationStatus ?? this.locationStatus);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [locationStatus];
}
