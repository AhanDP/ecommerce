import '../review.dart';

class ReviewResponse {
  String message = '';
  List<Review> reviews = [];

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';

    if (json['data'] != null && json['data'] is List) {
      reviews = json['data'].map<Review>((e) => Review.fromJson(Map<String, dynamic>.from(e))).toList();
    }
  }
}