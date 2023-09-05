import 'dart:convert';

List<CarModel> carModelFromJson(String str) =>
    List<CarModel>.from(json.decode(str).map((x) => CarModel.fromJson(x)));

String carModelToJson(List<CarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarModel {
  int id;
  int price;
  String type;
  String image;
  String name;

  CarModel({
    required this.id,
    required this.price,
    required this.type,
    required this.image,
    required this.name,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        price: json["price"],
        type: json["type"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "type": type,
        "image": image,
        "name": name,
      };
}
