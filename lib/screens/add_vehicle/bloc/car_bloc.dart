/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:addrive/screens/add_vehicle/db/car_db.dart';
import 'package:addrive/screens/add_vehicle/model/car_details_model.dart';
import 'package:addrive/screens/add_vehicle/model/car_model.dart';
import 'package:addrive/screens/add_vehicle/service/car_service.dart';
import 'package:addrive/utils/enums/status.dart';

import '../../../global/imports/app_imports.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc() : super(const CarState()) {
    on<GetCarsEvent>(_getCars);
    on<GetCarDetailsEvent>(_getCarDetails);
  }

  final CarsService _carsService = CarsService();
  final CarDb _carDb = CarDb();

  Future<void> _getCars(GetCarsEvent event, Emitter<CarState> emit) async {
    emit(state.copyWith(carStatus: ActionStatus.isLoading));
    Either<String, List<CarModel>> data = await _carsService.getAllCars();
    List<CarModel>? dataFromDb = await _carDb.getCars();
    data.fold((l) {
      if (dataFromDb != null) {
        state.copyWith(carStatus: ActionStatus.isSuccess, carModel: dataFromDb);
      } else {
        emit(state.copyWith(carStatus: ActionStatus.isError, carsError: l));
      }
    }, (r) async {
      emit(state.copyWith(carStatus: ActionStatus.isSuccess, carModel: r));
      await _carDb.writeToDbCars(r);
    });
  }

  Future<void> _getCarDetails(
      GetCarDetailsEvent event, Emitter<CarState> emit) async {
    emit(state.copyWith(carDetailsStatus: ActionStatus.isLoading));
    Either<String, List<CarDetailsModel>> data =
        await _carsService.getCarDetails(event.id);
    CarDetailsModelMain? dataFromDb = await _carDb.getCarDetails(event.id);
    data.fold((l) {
      if (dataFromDb != null) {
        state.copyWith(
            carDetailsStatus: ActionStatus.isSuccess,
            carDetailsModel: dataFromDb.carDetailsModel);
      } else {
        emit(state.copyWith(
            carDetailsStatus: ActionStatus.isError, carsDetailsError: l));
      }
    }, (r) async {
      emit(state.copyWith(
          carDetailsStatus: ActionStatus.isSuccess, carDetailsModel: r));
      await _carDb.writeToDbCarDetails(CarDetailsModelMain(event.id, r));
    });
  }
}
