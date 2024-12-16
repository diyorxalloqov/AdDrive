class BasicSetting {
  bool? success;
  Data? data;

  BasicSetting({
    this.success,
    this.data,
  });

  factory BasicSetting.fromJson(Map<String, dynamic> json) => BasicSetting(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  String? name;
  String? value;

  Data({
    this.name,
    this.value,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}
