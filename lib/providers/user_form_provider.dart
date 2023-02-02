import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/usuario.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late GlobalKey<FormState> formKey;

  // void updateListener() {
  //   notifyListeners();
  // }

  // copyUserWith({
  //   String? rol,
  //   bool? estado,
  //   bool? google,
  //   String? nombre,
  //   String? correo,
  //   String? uid,
  //   String? img,
  // }) {
  //   user = Usuario(
  //     rol: rol ?? user!.rol,
  //     estado: estado ?? user!.estado,
  //     google: google ?? user!.google,
  //     nombre: nombre ?? user!.nombre,
  //     correo: correo ?? user!.correo,
  //     uid: uid ?? user!.uid,
  //     img: img ?? user!.img,
  //   );
  //   notifyListeners();
  // }

//SPRINT
  copyUserWith({
    String? id,
    String? firstname,
    String? lastname,
    String? username,
    String? password,
    // List<Role>? roles,
    bool? estado,
    String? correo,
    String? img,
  }) =>
      Usuario(
        id: id ?? user!.id,
        firstname: firstname ?? user!.firstname,
        lastname: lastname ?? user!.lastname,
        username: username ?? user!.username,
        password: password ?? user!.password,
        // roles: roles ?? user!.roles,
        estado: estado ?? user!.estado,
        correo: correo ?? user!.correo,
        img: img ?? user!.img,
      );
//SPRINT

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser() async {
    if (!_validForm()) return false;

    // final data = {
    //   'nombre': user!.nombre,
    //   'correo': user!.correo,
    // };

    //SPRINT
    final data = {
      'username': user!.username,
      'firstname': user!.firstname,
      'lastname': user!.lastname,
      'correo': user!.correo,
    };

    {}
    //SPRINT

    // try {
    //   final resp = await CafeApi.put('/usuarios/${user!.uid}', data);
    //   print(resp);
    //   return true;
    // } catch (e) {
    //   print('error en updateUser: $e');
    //   return false;
    // }

    //SPRINT
    try {
      final resp = await CafeApi.put('/users/${user!.id}', data);
      print(resp);
      return true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
    //SPRINT
  }

  // metodo para subir la imagen al backend

  Future<Usuario> uploadImage(String path, Uint8List bytes) async {
    try {
      final resp = await CafeApi.uploadFile(path, bytes);
      user = Usuario.fromMap(resp);
      notifyListeners();
      return user!;
    } catch (e) {
      print(e);
      throw "Error en profile provider";
    }
  }
}
