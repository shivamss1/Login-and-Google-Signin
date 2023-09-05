// To parse this JSON data, do
//
//     final googlemodel = googlemodelFromJson(jsonString);

import 'dart:convert';

Googlemodel googlemodelFromJson(String str) =>
    Googlemodel.fromJson(json.decode(str));

String googlemodelToJson(Googlemodel data) => json.encode(data.toJson());

class Googlemodel {
  Googlemodel({
    required this.userId,
    required this.userName,
    required this.emailId,
    required this.profileImage,
    required this.createdAt,
  });

  int userId;
  String userName;
  String emailId;
  String profileImage;
  DateTime createdAt;

  factory Googlemodel.fromJson(Map<String, dynamic> json) => Googlemodel(
        userId: json["userId"],
        userName: json["userName"],
        emailId: json["emailId"],
        profileImage: json["profileImage"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "emailId": emailId,
        "profileImage": profileImage,
        "createdAt": createdAt.toIso8601String(),
      };
}
