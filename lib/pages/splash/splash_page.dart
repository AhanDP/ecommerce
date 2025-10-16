import 'package:ecommerce/components/loader.dart';
import 'package:flutter/material.dart';
import '../../navigation/navigation.dart';
import '../../navigation/route_path.dart';
import '../../utills/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (){
      Navigation.instance.navigateAndRemoveUntil(RoutePath.loginRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Constants.bgColor,
        ),
        backgroundColor: Constants.bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                Text("Ecommerce", style: TextStyle(color: Constants.primaryTextColor, fontSize: 30, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text("Your Shopping, Simplified.", style: TextStyle(color: Constants.secondaryTextColor, fontSize: 18, fontWeight: FontWeight.w400)),
                const Spacer(),
                const Loader(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        )
    );
  }
}