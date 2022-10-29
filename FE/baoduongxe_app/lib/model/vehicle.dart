import 'dart:convert';

List<Vehicle> vehicleFromJson(String str) =>
    List<Vehicle>.from(json.decode(str).map((x) => Vehicle.fromJson(x)));

String vehicleToJson(List<Vehicle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vehicle {
  Vehicle({
    this.vehicleId,
    this.vehicleName,
    this.description,
    this.image,
    this.categoryVehicleName,
  });

  String? vehicleId;
  String? vehicleName;
  String? description;
  String? image;
  String? categoryVehicleName;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        vehicleId: json["vehicleId"],
        vehicleName: json["vehicleName"],
        description: json["description"],
        image: json["image"],
        categoryVehicleName: json["categoryVehicleName"],
      );

  Map<String, dynamic> toJson() => {
        //"vehicleId": vehicleId,
        "vehicleName": vehicleName,
        "description": description,
        "image": image,
        "categoryVehicleName": categoryVehicleName,
      };
}
