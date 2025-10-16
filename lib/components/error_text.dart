import 'package:flutter/material.dart';
import '../utills/constants.dart';
import 'button.dart';

class ErrorText extends StatelessWidget {
  final String? title;
  final String error;
  final Function() onRetry;

  const ErrorText({super.key, required this.error, required this.onRetry, this.title});

  @override
  Widget build(BuildContext context) {
    bool isBluetoothError = error.contains("bluetooth");
    bool isLocationError = error.contains("location");
    bool isInternetError = error.contains("No internet");
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16,),
          Container(
            decoration: BoxDecoration(
              color: Constants.cardBgColor,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(16),
            child: (isInternetError) ? Image.asset("assets/images/no_internet.png", color: Colors.red, height: 42, width: 42,) : (isBluetoothError) ? Icon(Icons.bluetooth, color: Constants.primary, size: 42,) :
            (isLocationError) ? Icon(Icons.location_on_outlined, color: Constants.primary, size: 42,) : const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 42,),
          ),
          const SizedBox(height: 20,),
          Text((isBluetoothError) ? "Bluetooth" : (isLocationError) ? "Location" : (isInternetError) ? "No Internet" : "Error", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Constants.primaryTextColor),textAlign: TextAlign.center,),
          const SizedBox(height: 16),
          Text(error, style: TextStyle(fontSize: 14, color: Constants.secondaryTextColor, fontWeight: FontWeight.w400, height: 1.8),textAlign: TextAlign.center, maxLines: 5,),
          const SizedBox(height: 24),
          Button(btnText: "Retry", onPressed: onRetry)
        ],
      ),
    );
  }
}
