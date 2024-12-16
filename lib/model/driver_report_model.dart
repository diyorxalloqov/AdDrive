class DriverReport{

  final String? name;
  final String? date;
  final String? time;
  final String? distance;
  final int? trackingId;
  final List<ReportLocation>? locations;

  DriverReport({this.name, this.date, this.time, this.distance, this.locations, this.trackingId});

}

class ReportLocation{

  final double latitude;
  final double longitude;

  ReportLocation(this.latitude, this.longitude);

}