import 'package:ecommerce/models/product.dart';

class ProductResponse {
  String message = '';
  List<Product> products = [];

  ProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    if (json['data'] != null && json['data']['products'] != null) {
      if (json['data']['products'] is List) {
        products = json['data']['products']
            .map<Product>((e) => Product.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else if (json['data']['products'] is Map) {
        products = [Product.fromJson(Map<String, dynamic>.from(json['data']['products']))];
      }
    }
  }
}
