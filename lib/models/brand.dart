class Brand {
  String id = '';
  String title = '';
  String description = '';
  String handle = '';
  String image = '';
  String status = '';

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    handle = json['handle'] ?? '';
    image = json['image'] ?? '';
    status = json['status'] ?? '';
  }
}