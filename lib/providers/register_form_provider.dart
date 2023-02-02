import 'dart:developer';

import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  // String name = '';
  // String email = '';
  // String password = '';

  //SPRINT

  String username = '';
  String firstname = '';
  String lastname = '';
  String email = '';
  String password = '';

  //SPRINT

  validateForm() {
    if (formKey.currentState!.validate()) {
      log("Form Valid ... Login");
      // log("$email === $password === $name");
      log("$email === $password === $username === $firstname === $lastname");

      return true;
    } else {
      log("form not valid ...");
      return false;
    }
  }
}
