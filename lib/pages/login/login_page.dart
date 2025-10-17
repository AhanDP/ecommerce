import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/button.dart';
import '../../components/custom_app_bar.dart';
import '../../components/label.dart';
import '../../components/passwordfield.dart';
import '../../components/textfield.dart';
import '../../utils/constants.dart';
import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bgColor,
      appBar: CustomAppBar(title: "Login", canLeadBack: true),
      body: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
        child: const LoginWidget(),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return Form(
      key: loginCubit.loginFormKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Label(text: "Email address"),
                  CustomTextField(
                    autofocus: true,
                    hint: "Enter your email address",
                    controller: loginCubit.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter email address';
                      } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(value)) {
                        return 'Enter valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Label(text: "Password"),
                  PasswordField(
                    autofocus: false,
                    hint: "Enter password",
                    controller: loginCubit.passwordController,
                    maxLength: 16,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter password';
                      } else if (value.length < 8) {
                        return 'Enter valid password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Button(
                  btnText: "Login",
                  bgColor: Constants.primary,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    loginCubit.login();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}