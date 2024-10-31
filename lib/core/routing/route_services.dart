import 'package:flutter/material.dart';
import 'package:shop_sql/core/routing/routes.dart';
import 'package:shop_sql/features/main_screen/presentation/view/screen/main_screen.dart';
import 'package:shop_sql/features/splash/splash_screen.dart';

class RouteServices {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // ('generateRoute => ${routeSettings.name}');
    //safePrint('generateRoute => ${routeSettings.arguments}');

    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
        case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (_) =>  const MainScreen(),
        );


      default:
        return _errorRoute();
    }
  }










  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Page Not Found"),
        ),
      );
    });
  }
}
