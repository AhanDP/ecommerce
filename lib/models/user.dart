class User {
  String id = '';
  String name = '';
  String email = '';
  String refreshToken = '';
  String accessToken = '';

  User.fromJson(Map<String, dynamic> json) {
    id = json['user']['id'] ?? '';
    name = json['user']['firstName'] ?? '';
    email = json['user']['email'] ?? '';
    refreshToken = json['tokens']['refreshToken'] ?? '';
    accessToken = json['tokens']['accessToken'] ?? '';
  }
}