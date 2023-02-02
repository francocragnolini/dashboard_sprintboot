import 'package:flutter/cupertino.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

// ej: cuando se va a la pantalla del dashboard, el usuario no deberia poder
// regresar al login
// remueve el login Page ( tiene scaffold) del stack
  static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
