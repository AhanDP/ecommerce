class Variant {
  String id = '';
  int originalPrice = 0;
  int currentPrice = 0;

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    originalPrice = json['originalPrice'] ?? 0;
    currentPrice = json['currentPrice'] ?? 0;
  }
}