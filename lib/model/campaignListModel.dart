import 'dart:convert';


CampaignListModel campaignListModelFromJson(String str) => CampaignListModel.fromJson(json.decode(str));

class CampaignListModel {
  bool? success;
  String? message;
  Data? data;

  CampaignListModel({
    this.success,
    this.message,
    this.data,
  });

  factory CampaignListModel.fromJson(Map<String, dynamic> json) => CampaignListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Campaign>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null
        ? []
        : List<Campaign>.from(json["data"].map((x) => Campaign.fromJson(x))),
  );
}

class Campaign {
  int? id;
  String? name;
  String? brandImage;
  String? clientName;
  String? type;
  String? location;
  String? duration;
  String? amount;
  bool? isAssignedAlready;

  Campaign({
    this.id,
    this.name,
    this.brandImage,
    this.clientName,
    this.type,
    this.location,
    this.duration,
    this.amount,
    this.isAssignedAlready,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json["id"],
    name: json["name"],
    brandImage: json["brand_image"],
    clientName: json["client_name"],
    type: json["type"],
    location: json["location"],
    duration: json["duration"],
    amount: json["amount"],
    isAssignedAlready: json["is_assigned_already"],
  );
}
