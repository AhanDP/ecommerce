import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../localStorage/local_storage.dart';
import '../../navigation/navigation.dart';
import '../../navigation/route_path.dart';
import '../../network/api_call_handler.dart';
import '../../network/api_service.dart';
import '../../utils/helpers.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    init();
  }
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void init() {
    emailController.text = "admin@admin.com";
    passwordController.text = "supersecret";
  }

  Future<void> login() async {
    if (loginFormKey.currentState?.validate() == true) {
      loginFormKey.currentState?.save();

      Map<String, dynamic> request = {
        "email": emailController.text.replaceAll(" ", ""),
        "password": passwordController.text,
      };

      await ApiCallHandler.call(
        apiCall: () async => await ApiProvider.instance.login(request),
        onLoading: () => Helpers.showLoadingDialog(),
        onSuccess: (response) async {
          Navigation.instance.goBack();
          Helpers.showToast("Login Successful");
          await LocalStorage.instance.saveUserDetails(response?.user);
          Navigation.instance.navigateAndRemoveUntil(RoutePath.homeRoute);
        },
        onFailure: (errorMsg, isNetworkError) {
          Navigation.instance.goBack();
          if (isNetworkError) {
            Helpers.showNoInternetDialog();
          } else {
            Helpers.showErrorDialog(errorMsg);
          }
        },
      );
    }
  }
}
