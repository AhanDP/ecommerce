import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';

import '../components/custom_dialog.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Helpers {

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? "";
    return parsedString;
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.grey.shade700,
        fontSize: 15);
  }

  static void showLoadingDialog({String? loadingText}) {
    CustomDialog.instance.showLoadingDialog();
  }

  static void showNoInternetDialog() {
    CustomDialog.instance.showErrorDialog(title: "No internet connection", error: "No internet connection detected. Please ensure you are connected to a network.");
  }

  static void showErrorDialog(String errMsg) {
    CustomDialog.instance.showErrorDialog(title: "ERROR", error: errMsg);
  }
}
