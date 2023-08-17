// import 'dart:convert';
//
// List<ColorModel> productModelFromJson(String str) => List<ColorModel>.from(json.decode(str).map((x) => ColorModel.fromJson(x)));
//
// String productModelToJson(List<ColorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class ColorModel {
//   String id;
//   String color;
//
//   ColorModel({
//     required this.id,
//     required this.color,
//   });
//
//   factory ColorModel.fromJson(Map<String, dynamic> data) => ColorModel(
//       id: data["id"],
//       color: data['color']
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     'color': color,
//   };
// }
