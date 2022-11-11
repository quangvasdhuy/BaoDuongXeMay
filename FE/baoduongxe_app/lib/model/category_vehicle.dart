import 'dart:convert';

List<CategoryVehicle> categoryVehicleFromJson(String str) => List<CategoryVehicle>.from(json.decode(str).map((x) => CategoryVehicle.fromJson(x)));

String categoryVehicleToJson(List<CategoryVehicle> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryVehicle {
  CategoryVehicle({
    this.categoryVehicleId,
    this.categoryVehicleName,
    this.image,
  });

  String? categoryVehicleId;
  String? categoryVehicleName;
  String? image;

  factory CategoryVehicle.fromJson(Map<String, dynamic> json) => CategoryVehicle(
    categoryVehicleId: json["categoryVehicleID"],
    categoryVehicleName: json["categoryVehicleName"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "categoryVehicleID": categoryVehicleId,
    "categoryVehicleName": categoryVehicleName,
    "image": image,
  };
}
