import 'package:ecommerce/pages/home/home_page.dart';
import 'package:ecommerce/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import '../pages/splash/splash_page.dart';
import 'route_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    //splash route
    case RoutePath.splashRoute: return MaterialPageRoute(builder: (_) =>  const SplashPage());
    //auth routes
    case RoutePath.loginRoute: return MaterialPageRoute(builder: (_) =>  const LoginPage());

    //main routes
    case RoutePath.homeRoute: return MaterialPageRoute(builder: (_) =>  const HomePage());

    default:
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
          body: Center(
            child: Text('404 Page not found ${settings.name}'),
          ),
        );
      });
  }
}