import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'localStorage/local_storage.dart';
import 'navigation/navigation.dart';
import 'navigation/route_path.dart';
import 'navigation/routes.dart';
import 'package:logging/logging.dart';
import 'network/http_overrides.dart';
import 'utills/constants.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.registerSharedPreferences();
  HttpOverrides.global = MyHttpOverrides();
  _setupLogging();
  runApp(const Main());
}

void _setupLogging() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    if (kDebugMode) {
      debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });
}

class Main extends StatelessWidget {
  const Main({super.key});

  void _setSystemUiOverlay(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor:Constants.primaryTextColor,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Constants.primaryTextColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _setSystemUiOverlay();
    return MaterialApp(
      title: 'Ecommerce',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'SpaceGrotesk',
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Constants.primary,
          primaryColorLight: Constants.primary,
          primaryColorDark: Constants.primary,
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          )
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: Navigation.instance.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: RoutePath.splashRoute,
    );
  }
}