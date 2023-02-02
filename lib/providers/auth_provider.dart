import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/cafe_api.dart';

import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/models/usuario.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  // lOGIN
  // login(String email, String password) {
  //   final data = {'correo': email, 'password': password};

  //   CafeApi.post('/auth/login', data).then((json) {
  //     print(json);
  //     final authResponse = AuthResponse.fromMap(json);
  //     user = authResponse.usuario;
  //     // cambia el status de conectado con el main.dart
  //     authStatus = AuthStatus.authenticated;
  //     // guarda el token en el local Storage
  //     LocalStorage.prefs.setString('token', authResponse.token!);

  //     // navega al dashboard
  //     NavigationService.replaceTo(Flurorouter.dashboardRoute);

  //     // Para usar el nuevo token generado
  //     CafeApi.configureDio();

  //     notifyListeners();
  //   }).catchError((e) {
  //     print('error en: $e');
  //     NotificationsService.showSnackbarError('Usuario / Password no válidos');
  //   });
  // }

  //SPRINT LOGIN MODIFICACION : ESTADO FUNCIONANDO
  login(String username, String password) {
    final payload = {'username': username, 'password': password};

    CafeApi.post('/auth/authenticate', payload).then((json) {
      print(json);

      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.user;
      // cambia el status de conectado con el main.dart
      authStatus = AuthStatus.authenticated;
      // guarda el token en el local Storage
      LocalStorage.prefs.setString('token', authResponse.token!);

      // navega al dashboard
      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      // Para usar el nuevo token generado
      CafeApi.configureDio();

      notifyListeners();
    }).catchError((e) {
      print('error en: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });
  }
  //SPRINT MODIFICACION LOGIN : ESTADO FUNCIONANDO

  // //REGISTER
  // register(String email, String password, String name) {
  //   final data = {'nombre': name, 'correo': email, 'password': password};

  //   CafeApi.post('/usuarios', data).then((json) {
  //     print(json);
  //     final authResponse = AuthResponse.fromMap(json);
  //     user = authResponse.user;

  //     authStatus = AuthStatus.authenticated;
  //     LocalStorage.prefs.setString('token', authResponse.token!);
  //     NavigationService.replaceTo(Flurorouter.dashboardRoute);

  //     CafeApi.configureDio();
  //     notifyListeners();
  //   }).catchError((e) {
  //     print('error en: $e');
  //     NotificationsService.showSnackbarError('Usuario / Password no válidos');
  //   });
  // }

  //SPRINT MODIFICACION REGISTER
  register(String username, String firstname, String lastname, String email,
      String password) {
    final data = {
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'correo': email,
      'password': password,
    };

    CafeApi.post('/auth/register', data).then((json) {
      print(json);
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.user;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      CafeApi.configureDio();
      notifyListeners();
    }).catchError((e) {
      print('error en: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });
  }
  //  //SPRINT MODIFICACION REGISTER

  //IS AUTHENTICATED
  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp = await CafeApi.httpGet('/auth');
      final authReponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token', authReponse.token!);

      user = authReponse.user;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  //lOGOUT
  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
