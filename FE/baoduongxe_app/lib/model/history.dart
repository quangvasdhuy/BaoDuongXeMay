import 'dart:convert';

List<History> historyFromJson(String str) => List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

String historyToJson(List<History> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class History {
  History({
    this.idHistory,
    this.idDetailNau,
    this.idDeatil,
    this.repairDate,
    this.totalCost,
    this.kmAccumulation,
  });

  @override
  String toString() {
    return '{$idHistory,$idDetailNau,$idDeatil,$repairDate,$totalCost,$kmAccumulation}';
  }

  String? idHistory;
  String? idDetailNau;
  String? idDeatil;
  String? repairDate;
  int? totalCost;
  int? kmAccumulation;

  factory History.fromJson(Map<String, dynamic> json) => History(
    idHistory: json["idHistory"],
    idDetailNau: json["idDetailNAU"],
    idDeatil: json["idDeatil"],
    repairDate: json["repairDate"],
    totalCost: json["totalCost"],
    kmAccumulation: json["km_accumulation"],
  );

  Map<String, dynamic> toJson() => {
    "idHistory": idHistory,
    "idDetailNAU": idDetailNau,
    "idDeatil": idDeatil,
    "repairDate": repairDate,
    "totalCost": totalCost,
    "km_accumulation": kmAccumulation,
  };
}
