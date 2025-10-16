import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../navigation/navigation.dart';
import '../navigation/route_path.dart';

class LocalStorage {
  LocalStorage._();

  static LocalStorage instance = LocalStorage._();

  late SharedPreferences sharedPreferences;
  bool isJailBreak = false;

  Future<void> registerSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  get isLoggedIn => sharedPreferences.getBool("isLoggedIn") ?? false;
  get accessToken => sharedPreferences.getString("accessToken") ?? "";
  get refreshToken => sharedPreferences.getString("refreshToken") ?? "";
  get name => sharedPreferences.getString("name") ?? "";
  get email => sharedPreferences.getString("email") ?? "";

  Future<void> saveUserDetails(User? user) async {
    await sharedPreferences.setBool("isLoggedIn", true);
    await sharedPreferences.setString("name", user?.name ?? "");
    await sharedPreferences.setString("email", user?.email ?? "");
    await setTokens(user?.accessToken ?? "", user?.refreshToken ?? "");
  }

  Future<void> setTokens(accessToken, refreshToken) async{
    await sharedPreferences.setString("accessToken", accessToken);
    await sharedPreferences.setString("refreshToken", refreshToken);
  }

  Future<void> logout() async {
    await sharedPreferences.setBool("isLoggedIn", false);
    await sharedPreferences.setString("accessToken", "");
    await sharedPreferences.setString("refreshToken", "");
    await sharedPreferences.setString("name", "");
    await sharedPreferences.setString("email", "");
    Navigation.instance.navigateAndRemoveUntil(RoutePath.splashRoute);
  }
}