import 'package:ecommerce/models/variant.dart';

class Product{
  String id = '';
  String title = '';
  double averageRating = 0.0;
  List<Variant> variants = [];
  String thumbnail = '';
  bool isFavourite = false;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    thumbnail = json['thumbnail'] ?? '';
    averageRating = json['averageRating'] ?? 0.0;
    title = json['title'] ?? '';
    variants = (json['variants'] != null) ? json['variants'].map<Variant>((e) => Variant.fromJson(e)).toList() : [];
  }
}