// To parse this JSON data, do
//
//     final changeFavVm = changeFavVmFromJson(jsonString);

import 'dart:convert';

ChangeFavVm changeFavVmFromJson(String str) => ChangeFavVm.fromJson(json.decode(str));

String changeFavVmToJson(ChangeFavVm data) => json.encode(data.toJson());

class ChangeFavVm {
  ChangeFavVm({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  FavData ?data;

  factory ChangeFavVm.fromJson(Map<String, dynamic> json) => ChangeFavVm(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : FavData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class FavData {
  FavData({
    this.id,
    this.product,
  });

  int? id;
  Product? product;

  factory FavData.fromJson(Map<String, dynamic> json) => FavData(
    id: json["id"] == null ? null : json["id"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product": product == null ? null : product!.toJson(),
  };
}

class Product {
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
  });

  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] == null ? null : json["id"],
    price: json["price"] == null ? null : json["price"],
    oldPrice: json["old_price"] == null ? null : json["old_price"],
    discount: json["discount"] == null ? null : json["discount"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "price": price == null ? null : price,
    "old_price": oldPrice == null ? null : oldPrice,
    "discount": discount == null ? null : discount,
    "image": image == null ? null : image,
  };
}
