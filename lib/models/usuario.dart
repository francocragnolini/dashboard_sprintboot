// import 'dart:convert';

// class Usuario {
//   Usuario({
//     required this.rol,
//     required this.estado,
//     required this.google,
//     required this.nombre,
//     required this.correo,
//     required this.uid,
//     this.img,
//   });

//   final String rol;
//   final bool estado;
//   final bool google;
//   final String nombre;
//   final String correo;
//   final String uid;
//   // imagen opcional(propiedad agregada manualmente)
//   final String? img;

//   factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
//         rol: json["rol"],
//         estado: json["estado"],
//         google: json["google"],
//         nombre: json["nombre"],
//         correo: json["correo"],
//         uid: json["uid"],
//         img: json["img"],
//       );

//   Map<String, dynamic> toMap() => {
//         "rol": rol,
//         "estado": estado,
//         "google": google,
//         "nombre": nombre,
//         "correo": correo,
//         "uid": uid,
//         "img": img,
//       };
// }

import 'dart:convert';

class Usuario {
  Usuario({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.password,
    // required this.roles,
    required this.estado,
    required this.correo,
    this.img,
  });

  final String id;
  final String firstname;
  final String lastname;
  final String username;
  final String password;
  // final List<Role> roles;
  final bool estado;
  final String correo;
  final String? img;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["id"].toString(),
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        password: json["password"],
        // roles: List<Role>.from(json["roles"].map((x) => Role.fromMap(x))),
        estado: json["estado"],
        correo: json["correo"],
        img: json["img"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "password": password,
        // "roles": List<dynamic>.from(roles.map((x) => x.toMap())),
        "estado": estado,
        "correo": correo,
        "img": img,
      };
}

// class Role {
//   Role({
//     required this.id,
//     required this.name,
//   });

//   final int id;
//   final String name;

//   factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Role.fromMap(Map<String, dynamic> json) => Role(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//       };
// }
