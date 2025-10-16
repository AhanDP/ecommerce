import '../user.dart';

class LoginResponse {
  User? user;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['data']);
  }
}
