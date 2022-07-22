// To parse this JSON data, do
//
//     final userVm = userVmFromJson(jsonString);

import 'dart:convert';

UserVm userVmFromJson(String str) => UserVm.fromJson(json.decode(str));

String userVmToJson(UserVm data) => json.encode(data.toJson());

 class UserVm {
  UserVm({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data ?data;

  factory UserVm.fromJson(Map<String, dynamic> json) => UserVm(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  int ?id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    image: json["image"] == null ? null : json["image"],
    points: json["points"] == null ? null : json["points"],
    credit: json["credit"] == null ? null : json["credit"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "image": image == null ? null : image,
    "points": points == null ? null : points,
    "credit": credit == null ? null : credit,
    "token": token == null ? null : token,
  };
}
