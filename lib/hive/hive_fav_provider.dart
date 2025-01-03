
import 'package:flutter/material.dart';
import 'package:addrive/model/hive_model/fav/favourite_car_model.dart';
import 'package:hive/hive.dart';

const String favBoxName = "favBox";

class FavService with ChangeNotifier{

  final box = Hive.box<FavoriteCar>(favBoxName);


  void addCarToFavList(FavoriteCar favoriteCar) async {
    await box.add(favoriteCar);
    notifyListeners();
  }

  void removeCarToFavListById({required int id}) async {
    await box.deleteAt(getIndexOfFavList(id: id));
    notifyListeners();
  }

  int getIndexOfFavList({required int id}){
    return getAllFavCar().indexWhere((element) => element.id == id);
  }

  List<FavoriteCar> getAllFavCar(){
    return box.values.toList();
  }

  int favCarCount(){
    return getAllFavCar().length;
  }

  bool isCarAlreadyInFavList(int favCarId){
    final checkFavCarList = box.values.where((element) => element.id == favCarId).toList();
    if (checkFavCarList.isNotEmpty){
      return true;
    } else{
      return false;
    }
  }

}