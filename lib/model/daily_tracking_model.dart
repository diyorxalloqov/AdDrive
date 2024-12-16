class DailyTrackingDetails {
  List<DailyTrackingList>? data;
  bool? success;
  String? message;
  String? duration;
  String? distance;
  String? startTime;
  List<GeoLocationsDetails>? geoLocation;

  DailyTrackingDetails(
      {this.data,
      this.success,
      this.message,
      this.duration,
      this.distance,
      this.startTime,
      this.geoLocation});

  factory DailyTrackingDetails.fromJson(Map<String, dynamic> json) {
    return DailyTrackingDetails(
      data: json['data'] != null
          ? List<DailyTrackingList>.from(
              json['data'].map((e) => DailyTrackingList.fromJson(e)))
          : null,
      success: json["success"],
      message: json["message"],
      duration: json["duration"],
      distance: json["distance"],
      startTime: json["start_time"],
      geoLocation: List<GeoLocationsDetails>.from(
          json["geo_location"].map((x) => GeoLocationsDetails.fromJson(x))),
    );
  }
}

class DailyTrackingList {
  double? latitude;
  double? longitude;

  DailyTrackingList({this.latitude, this.longitude});

  factory DailyTrackingList.fromJson(Map<String, dynamic> json) {
    return DailyTrackingList(
      latitude: json["latitude"]?.toDouble(),
      longitude: json["longitude"]?.toDouble(),
    );
  }
}

class GeoLocationsDetails {
  String? start;
  double? longitude;
  double? latitude;
  DateTime? createdAt;
  String? end;

  GeoLocationsDetails(
      {this.start, this.longitude, this.latitude, this.createdAt, this.end});

  factory GeoLocationsDetails.fromJson(Map<String, dynamic> json) =>
      GeoLocationsDetails(
        start: json["start"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        end: json["end"],
      );
}
