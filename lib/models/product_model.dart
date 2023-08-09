import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String? id;
  String? name;
  String? rank;
  String? sold;
  int? price;
  String? image;
  bool? isFavourite;
  String? description;
  String? status;

  ProductModel({
    this.id,
    this.name,
    this.rank,
    this.sold,
    this.price,
    this.image,
    this.isFavourite,
    this.description,
    this.status,
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
  };
}
