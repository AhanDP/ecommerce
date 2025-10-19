class Review {
  String id = '';
  int rating = 0;
  String comment = '';
  String customerName = '';
  String approvedAt = '';
  bool isPurchased = false;

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    rating = json['rating'] ?? 0;
    comment = json['comment'] ?? '';
    isPurchased = json['isPurchased'] ?? false;
    approvedAt = json['approvedAt'] ?? '';

    String firstName = json['customer']?['firstName'] ?? '';
    String lastName = json['customer']?['lastName'] ?? '';
    String fullName = '$firstName $lastName'.trim();

    if (fullName.isEmpty) {
      customerName = json['firstName'] ?? 'Anonymous';
    } else {
      customerName = fullName;
    }
  }
}