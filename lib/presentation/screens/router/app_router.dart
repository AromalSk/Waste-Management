import 'package:flutter/material.dart';
import 'package:waste_management/presentation/screens/authentication/splash_screen.dart';
import 'package:waste_management/presentation/screens/home/homepage.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomePage(),);
       case 'splash':
        return MaterialPageRoute(builder: (context) => const SplashScreen(),);
      default:
      return  MaterialPageRoute(builder: (context) => const HomePage(),);
    }
  }
}