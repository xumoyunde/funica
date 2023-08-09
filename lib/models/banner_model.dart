import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    required this.discount,
    required this.period,
    required this.description,
    required this.image,
  });

  String discount;
  String period;
  String description;
  String image;

  factory BannerModel.fromJson(Map<String, dynamic> data) => BannerModel(
        discount: data['discount'],
        period: data['period'],
        description: data['description'],
        image: data['image'],
      );

  Map<String, dynamic> toJson() => {
        'discount': discount,
        'period': period,
        'description': description,
        'image': image,
      };
}
