/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

part of 'car_bloc.dart';

sealed class CarEvent extends Equatable {
  const CarEvent();
}

class GetCarsEvent extends CarEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetCarDetailsEvent extends CarEvent {
  final String id;
  const GetCarDetailsEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
