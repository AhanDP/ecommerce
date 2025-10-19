import '../product.dart';

class SimilarProductResponse {
  String message = '';
  List<Product> similarProducts = [];

  SimilarProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';

    if (json['data'] != null && json['data'] is List) {
      similarProducts = json['data']
          .map<Product>((e) => Product.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
  }
}