/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

part of 'car_bloc.dart';

@immutable
class CarState extends Equatable {
  final ActionStatus carStatus;
  final String carsError;
  final List<CarModel> carModel;
  final ActionStatus carDetailsStatus;
  final String carsDetailsError;
  final List<CarDetailsModel> carDetailsModel;

  const CarState(
      {this.carModel = const [],
      this.carStatus = ActionStatus.isInitial,
      this.carsError = '',
      this.carDetailsModel = const [],
      this.carDetailsStatus = ActionStatus.isInitial,
      this.carsDetailsError = ''});

  CarState copyWith({
    ActionStatus? carStatus,
    String? carsError,
    List<CarModel>? carModel,
    ActionStatus? carDetailsStatus,
    String? carsDetailsError,
    List<CarDetailsModel>? carDetailsModel,
  }) {
    return CarState(
      carModel: carModel ?? this.carModel,
      carDetailsModel: carDetailsModel ?? this.carDetailsModel,
      carDetailsStatus: carDetailsStatus ?? this.carDetailsStatus,
      carsDetailsError: carsDetailsError ?? this.carsDetailsError,
      carStatus: carStatus ?? this.carStatus,
      carsError: carsError ?? this.carsError,
    );
  }

  @override
  List<Object?> get props => [
        carsError,
        carStatus,
        carModel,
        carDetailsModel,
        carDetailsStatus,
        carsDetailsError
      ];
}
