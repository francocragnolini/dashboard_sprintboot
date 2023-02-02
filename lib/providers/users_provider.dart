import 'dart:developer';

import 'package:admin_dashboard/models/http/users_response.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/cafe_api.dart';

import 'package:admin_dashboard/models/usuario.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  // si es la primera vez que estoy cargando los usuarios lo quiero en true
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  // constructor
  // apenas se utilize el UsersProvider ahi va a realizar la peticion http
  UsersProvider() {
    getPaginatedUsers();
  }

  // get Users
  // getPaginatedUsers() async {
  //   //Todo: peticion http
  //   final resp = await CafeApi.httpGet("/users?limite=100&desde=0");
  //   print(resp);
  //   final usersResponse = UsersResponse.fromMap(resp);

  //   users = [...usersResponse.usuarios];

  //   isLoading = false;

  //   notifyListeners();
  // }

  //SPRINT
  getPaginatedUsers() async {
    //Todo: peticion http
    final resp = await CafeApi.httpGet("/users");

    print(resp);

    final usersResponse = UsersResponse.fromMap(resp);

    log(usersResponse.users.toString());
    users = [...usersResponse.users];

    isLoading = false;

    notifyListeners();
  }
  //SPRINT

  Future<Usuario?> getUserById(String id) async {
    try {
      final resp = await CafeApi.httpGet("/users/$id");
      final user = Usuario.fromMap(resp);

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // ordena cualquier columna
  void sort<T>(Comparable<T> Function(Usuario user) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshUser(Usuario newUser) {
    users = users.map((user) {
      if (user.id == newUser.id) {
        user = newUser;
      }

      return user;
    }).toList();

    notifyListeners();
  }
}
