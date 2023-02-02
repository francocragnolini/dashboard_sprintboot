import 'dart:developer';

import 'package:flutter/material.dart';

class LoginFormProvider with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

//SPRINT
  String username = '';
//SPRINT
  // String email = '';
  String password = '';

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      // log("Form Valid ... Login");
      // log("$email === $password");
      return true;
    } else {
      log("form not valid ...");
      return false;
    }
  }
}
