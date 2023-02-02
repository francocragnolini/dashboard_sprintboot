import 'package:flutter/material.dart';

class SideMenuProvider extends ChangeNotifier {
// va a ayudar a la animacion para mostrar y esconder el menu
  static late AnimationController menuController;
  static bool isOpen = false;

  String _currentPage = "";

  String get currentPage {
    return _currentPage;
  }

  void setCurrentPageUrl(String routeName) {
    _currentPage = routeName;
    Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }

// hace la animaciion del movimiento de entrar y salir
// begin: - 200 (es el width del menu) end(0)
  static Animation<double> movement = Tween<double>(begin: -200, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

// muestra un overlay para cerrar el menu
  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static void openMenu() {
    isOpen = true;
    // dispara la animacion
    menuController.forward();
  }

  static void closeMenu() {
    isOpen = false;
    // dispara la animacion
    menuController.reverse();
  }

  static void toggleMenu() {
    if (isOpen) {
      menuController.reverse();
    } else {
      menuController.forward();
    }

    isOpen = !isOpen;
  }
}

// 1- variable menuController : esta asociado a dos animaciones (movement y opacity)
// 2- metodo openMenu:  cambia el valor booleano de isopen a true y dispara la animaxion