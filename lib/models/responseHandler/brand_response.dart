import '../brand.dart';

class BrandResponse {
  String message = '';
  Brand? brand;

  BrandResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    if (json['data'] != null && json['data'] is Map) {
      brand = Brand.fromJson(Map<String, dynamic>.from(json['data']));
    }
  }
}