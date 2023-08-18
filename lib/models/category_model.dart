import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({required this.name, required this.id});

  String name;
  String id;

  factory CategoryModel.fromJson(Map<String, dynamic> data) => CategoryModel(
        name: data['name'],
        id: data['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
