import 'dart:convert';

List<ARoomModel> aRoomModelFromJson(String str) => List<ARoomModel>.from(json.decode(str).map((x) => ARoomModel.fromJson(x)));

String aRoomModelToJson(List<ARoomModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ARoomModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  ARoomModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ARoomModel.fromJson(Map<String, dynamic> json) => ARoomModel(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}