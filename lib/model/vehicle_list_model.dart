VehiclesListModel vehiclesListModelFromJson(json) =>
    VehiclesListModel.fromJson(json);

class VehiclesListModel {
  VehiclesListModel({
    this.data,
    this.links,
    this.meta,
    this.success,
  });

  List<Datum>? data;
  Links? links;
  Meta? meta;
  bool? success;

  factory VehiclesListModel.fromJson(Map<String, dynamic> json) =>
      VehiclesListModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        success: json["success"],
      );
}

class Datum {
  Datum(
      {this.driverId,
      this.carImage,
      this.vehicleNo,
      this.cylinders,
      this.engine,
      this.abs,
      this.dimension,
      this.weight,
      this.horsePower,
      this.mileage,
      this.mpg,
      this.routePermit,
      this.fitness,
      this.license,
      this.displacement,
      this.vehicleName,
      this.vehicleModel,
      this.vehicleMakeYear,
      this.vehicleColor,
      this.status});

  int? driverId;
  String? carImage;
  String? vehicleNo;
  String? cylinders;
  String? engine;
  String? abs;
  String? dimension;
  String? weight;
  String? horsePower;
  String? mileage;
  String? mpg;
  String? routePermit;
  String? fitness;
  String? license;
  String? displacement;
  String? vehicleName;
  String? vehicleModel;
  int? vehicleMakeYear;
  String? vehicleColor;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        driverId: json["driver_id"],
        carImage: json['car_image'],
        vehicleNo: json["vehicle_no"],
        cylinders: json["cylinders"],
        engine: json["engine"],
        abs: json["abs"],
        dimension: json["dimension"],
        weight: json["weight"],
        horsePower: json["horse_power"],
        mileage: json['mileage'],
        mpg: json["mpg"],
        routePermit: json['route_permit'],
        fitness: json['fitness'],
        license: json['license'],
        displacement: json['displacement'],
        vehicleName: json["vehicle_name"],
        vehicleModel: json["vehicle_model"],
        vehicleMakeYear: json["vehicle_make_year"],
        vehicleColor: json["vehicle_color"],
        status: json["status"],
      );
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
