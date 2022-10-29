import 'dart:convert';

List<Accessary> accessaryFromJson(String str) => List<Accessary>.from(json.decode(str).map((x) => Accessary.fromJson(x)));

String accessaryToJson(List<Accessary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Accessary {
  Accessary({
    this.accessaryId,
    this.accessaryName,
    this.image,
  });

  String? accessaryId;
  String? accessaryName;
  String? image;

  factory Accessary.fromJson(Map<String, dynamic> json) => Accessary(
    accessaryId: json["accessaryID"],
    accessaryName: json["accessaryName"],
    image: json["image"] == null ? "" : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "accessaryID": accessaryId,
    "accessaryName": accessaryName,
    "image": image == null ? null : image,
  };
}
