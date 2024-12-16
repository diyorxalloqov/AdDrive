import 'package:flutter_texi_tracker/model/driver_location_model.dart';
import 'package:hive/hive.dart';

String location = 'location';

class HiveLocationProvider{

  var box = Hive.box<DriverLocationModel>(location);

  void add(DriverLocationModel location) async {
    await box.add(location);
  }

  DriverLocationModel? getUserLastPosition() {
    return box.isNotEmpty ? box.values.last: null;
  }

  DriverLocationModel? getUserFirstPosition() {
    return box.isNotEmpty ? box.values.first: null;
  }

  Future<void> deleteAllLocation() async{
    await box.clear();
  }
  List<Map<String,dynamic>> toMapList() {
    return box.values.map((e) => e.toJson()).toList();
  }

}
