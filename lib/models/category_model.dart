import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.name,
  });

  String name;

  factory CategoryModel.fromJson(Map<String, dynamic> data) => CategoryModel(
        name: data['name'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
