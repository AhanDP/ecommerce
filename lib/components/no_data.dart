import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'button.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String msg;
  final Function() onRetry;
  final bool? hideRetry;
  final Widget? imageWidget;
  final String? btnText;

  const NoDataWidget({super.key, required this.msg, required this.onRetry, required this.title, this.hideRetry, this.imageWidget, this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16,),
          imageWidget ?? Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(16),
            child: Image.asset("assets/images/no_data.jpg", height: 60, width: 60,)
          ),
          const SizedBox(height: 20,),
          Text(title, style: TextStyle(color: Constants.primaryTextColor, fontWeight: FontWeight.w600, fontSize: 18)),
          const SizedBox(height: 8),
          Text(msg, style: TextStyle(color: Constants.secondaryTextColor, fontWeight: FontWeight.w400, fontSize: 14), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          hideRetry != true ? Button(btnText: btnText ?? "Try Again", onPressed: onRetry) : const SizedBox.shrink()
        ],
      ),
    );
  }
}
