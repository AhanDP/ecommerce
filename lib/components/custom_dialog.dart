import 'dart:io';
import 'package:flutter/material.dart';
import 'button.dart';
import '../navigation/navigation.dart';
import '../utils/constants.dart';

class CustomDialog {
  CustomDialog._();

  static final CustomDialog instance = CustomDialog._();

  BuildContext? context = Navigation.instance.navigatorKey.currentContext;

  Future<void> showLoadingDialog({String? loadingText}) async {
    if (context != null) {
      await showDialog(
        context: context!,
        barrierDismissible: false,
        barrierColor: Colors.black26,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Constants.bottomBarBgColor,
                  borderRadius: BorderRadius.circular(54),
                ),
                height: 48,
                width: 48,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Constants.primary,
                    strokeWidth: 4,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> showErrorDialog({
    required String title,
    required String error,
  }) async {
    if (context != null) {
      await showDialog(
        context: context!,
        barrierColor: Colors.black26,
        useSafeArea: Platform.isIOS,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Constants.bottomBarBgColor,
            title: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Constants.primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            content: Text(
              error,
              style: TextStyle(
                fontSize: 14,
                color: Constants.secondaryTextColor,
                fontWeight: FontWeight.w400,
                height: 1.8,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            actions: [
              Button(
                height: 48,
                btnText: "OK",
                onPressed: () {
                  Navigation.instance.goBack();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
