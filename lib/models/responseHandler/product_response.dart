import 'package:ecommerce/models/product.dart';

class ProductResponse {
  String message = '';
  List<Product> products = [];

  ProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    products = (json['data']['products'] != null) ? json['data']['products'].map<Product>((e) => Product.fromJson(e)).toList : [];
  }
}