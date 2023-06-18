import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ngetrip/services/service.dart';

class PlaceModel {
  String? name;
  String? category;
  String? phone;
  int? price;
  String? address;
  LatLng? lang;
  List<String>? thumbnails;
  String? id;

  PlaceModel({
    this.name,
    this.category,
    this.phone,
    this.price,
    this.address,
    this.lang,
    this.thumbnails,
    this.id,
  });

  PlaceModel copyWith({
    String? name,
    String? category,
    String? phone,
    int? price,
    String? address,
    LatLng? lang,
    List<String>? thumbnails,
    String? id,
  }) =>
      PlaceModel(
        name: name ?? this.name,
        category: category ?? this.category,
        phone: phone ?? this.phone,
        price: price ?? this.price,
        address: address ?? this.address,
        lang: lang ?? this.lang,
        thumbnails: thumbnails ?? this.thumbnails,
        id: id ?? this.id,
      );

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        name: json["name"],
        category: json["category"],
        phone: json["phone"],
        price: json["price"],
        address: json["address"],
        lang: LatLng.fromJson(json["lang"]),
        thumbnails: json["thumbnails"] == null
            ? []
            : List<String>.from(
                json["thumbnails"]!.map((x) => '${AppService.url}/$x')),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "phone": phone,
        "price": price,
        "address": address,
        "lang": lang?.toJson(),
        "_id": id,
      };
}
