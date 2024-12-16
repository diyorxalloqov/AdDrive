import 'dart:convert';

SummeryModel summeryModelFromJson(String str) =>
    SummeryModel.fromJson(json.decode(str));

String summeryModelToJson(SummeryModel data) => json.encode(data.toJson());

class SummeryModel {
  SummeryModel({
    this.totalCar,
    this.totalDistance,
    this.amount,
    this.summary,
    this.graph,
  });

  int? totalCar;
  String? totalDistance;
  String? amount;
  List<Summary>? summary;
  Graph? graph;

  factory SummeryModel.fromJson(Map<String, dynamic> json) => SummeryModel(
        totalCar: json["total_car"],
        totalDistance: json["total_distance"],
        amount: json["amount"],
        summary: json["summary"] != null
            ? List<Summary>.from(
                json["summary"].map((x) => Summary.fromJson(x)))
            : [],
        graph: json["graph"] != null ? Graph.fromJson(json["graph"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "total_car": totalCar,
        "total_distance": totalDistance,
        "amount": amount,
        "summary": List<dynamic>.from(summary!.map((x) => x.toJson())),
        "graph": graph!.toJson(),
      };
}

class Graph {
  Graph({
    this.data,
  });

  List<Datum>? data;

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.month,
    this.distance,
  });

  String? month;
  dynamic distance;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        month: json["month"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "distance": distance,
      };
}

class Summary {
  Summary({
    this.month,
    this.distance,
    this.agreement,
  });

  String? month;
  dynamic distance;
  dynamic agreement;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        month: json["month"],
        distance: json["distance"],
        agreement: json["agreement"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "distance": distance,
        "agreement": agreement,
      };
}
