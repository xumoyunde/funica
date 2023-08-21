import 'dart:convert';

import 'package:funica/models/color_model.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String id;
  String name;
  String? rank;
  String? sold;
  int price;
  String image;
  bool isFavourite;
  String description;
  String status;
  String category;
  double? qty;

  // List<ColorModel> color;

  ProductModel({
    required this.id,
    required this.name,
    required this.rank,
    required this.sold,
    required this.price,
    required this.image,
    required this.isFavourite,
    required this.description,
    required this.status,
    required this.category,
    this.qty,
    // required this.color,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) => ProductModel(
        id: data["id"],
        name: data["name"],
        rank: data["rank"],
        sold: data["sold"],
        price: data["price"],
        image: data["image"],
        isFavourite: data["isFavourite"],
        description: data["description"],
        status: data["status"],
        category: data["category"],
        qty: data["qty"],
        // color: data['color']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rank": rank,
        "sold": sold,
        "price": price,
        "image": image,
        "isFavourite": isFavourite,
        "description": description,
        "status": status,
        "category": category,
        "qty": qty,
        // 'color': color,
      };

  @override
  ProductModel copyWith({
    double? qty,
  }) =>
      ProductModel(
        id: id,
        name: name,
        rank: rank,
        sold: sold,
        price: price,
        image: image,
        isFavourite: isFavourite,
        description: description,
        status: status,
        category: category,
        qty: qty ?? this.qty,
      );
}
