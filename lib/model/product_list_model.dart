// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<ProductListModel> productListModelFromJson(String str) => List<ProductListModel>.from(json.decode(str).map((x) => ProductListModel.fromJson(x)));

String productListModelToJson(List<ProductListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductListModel {
  int? id;
  String? title;
  String? price;
  String? description;
  List<String>? images;
  DateTime? creationAt;
  DateTime? updatedAt;
  Category? category;
  RxBool isFavorite;

  ProductListModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
    this.creationAt,
    this.updatedAt,
    this.category,
    bool isFavorite = false, // Default value is false
  }) : this.isFavorite = RxBool(isFavorite); // Initialize RxBool with initial value

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    id: json["id"],
    title: json["title"].toString(),
    price: json["price"].toString(),
    description: json["description"].toString(),
    images: List<String>.from(json["images"].map((x) => x)),
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    category: Category.fromJson(json["category"]),
    isFavorite: json["isFavorite"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toString(),
    "price": price.toString(),
    "description": description.toString(),
    "images": List<dynamic>.from(images!.map((x) => x)),
    "creationAt": creationAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "category": category!.toJson(),
    "isFavorite": isFavorite.value, // Access the boolean value of RxBool
  };
}

class Category {
  String? id;
  String? name;
  String? image;
  DateTime? creationAt;
  DateTime? updatedAt;

  Category({
     this.id,
     this.name,
     this.image,
     this.creationAt,
     this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"].toString(),
    name: json["name"].toString(),
    image: json["image"].toString(),
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "name": name.toString(),
    "image": image.toString(),
    "creationAt": creationAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}
