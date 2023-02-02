// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);

// import 'dart:convert';

// import 'package:admin_dashboard/models/usuario.dart';

// class UsersResponse {
//   UsersResponse({
//     required this.total,
//     required this.usuarios,
//   });

//   final int total;
//   final List<Usuario> usuarios;

//   factory UsersResponse.fromJson(String str) =>
//       UsersResponse.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
//         total: json["total"],
//         usuarios:
//             List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "total": total,
//         "usuarios": List<dynamic>.from(usuarios.map((x) => x.toMap())),
//       };
// }

// SPRINT
// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);

import 'package:admin_dashboard/models/usuario.dart';
import 'dart:convert';

class UsersResponse {
  UsersResponse({
    required this.count,
    required this.users,
  });

  final int count;
  final List<Usuario> users;

  factory UsersResponse.fromJson(String str) =>
      UsersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        count: json["count"],
        users: List<Usuario>.from(json["users"].map((x) => Usuario.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "users": List<dynamic>.from(users.map((x) => x.toMap())),
      };
}

//SPRINT 


















// enum Rol { USER_ROLE }

// final rolValues = EnumValues({"USER_ROLE": Rol.USER_ROLE});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String>? get reverse {
//     reverseMap ??= map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
