// To parse this JSON data, do
//
//     final authResponse = authResponseFromMap(jsonString);

// import 'dart:convert';

// import 'package:admin_dashboard/models/usuario.dart';

// class AuthResponse {
//   AuthResponse({
//     required this.usuario,
//     required this.token,
//   });

//   final Usuario? usuario;
//   final String? token;

//   factory AuthResponse.fromJson(String str) =>
//       AuthResponse.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
//         usuario: Usuario.fromMap(json["usuario"]),
//         token: json["token"],
//       );

//   Map<String, dynamic> toMap() => {
//         "usuario": usuario!.toMap(),
//         "token": token,
//       };
// }
// To parse this JSON data, do
//
//     final authResponse = authResponseFromMap(jsonString);

//SPRINT MODIFICACION
import 'dart:convert';
import 'package:admin_dashboard/models/usuario.dart';

class AuthResponse {
  AuthResponse({
    required this.user,
    required this.token,
  });

  final Usuario? user;
  final String? token;

  factory AuthResponse.fromJson(String str) =>
      AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        user: Usuario.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user": user!.toMap(),
        "token": token,
      };
}



//SPRINT MODIFICAION