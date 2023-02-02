import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:admin_dashboard/config.dart' show apiHost;
import 'package:admin_dashboard/services/local_storage.dart';

class CafeApi {
  static Dio _dio = Dio();

  // static void configureDio() {
  //   //Base url
  //   _dio.options.baseUrl = "http://mp.tipre.com:8080/api/v1";
  //   //MODIFICACION : Retorna url de produccion o desarrollo en base al enviroment(config.dart)
  //   // _dio.options.baseUrl = apiHost;

  //   // Configurar Headers
  //   // como puede que no lo tengamos en ese momento retorna un string vacio

  //   //CAMBIAR X-TOKEN POR Authorization: ver Postman get-users endpoint en headers
  //   _dio.options.headers = {
  //     'x-token': LocalStorage.prefs.getString("token") ?? "",
  //   };
  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onError: (e, handler) {
  //       switch (e.type) {
  //         case DioErrorType.response:
  //           print(e.message);
  //           throw ("Error en el POST");
  //           break;
  //         case DioErrorType.connectTimeout:
  //           print(e.message);
  //           throw ("Error en el POST");
  //           break;
  //         case DioErrorType.other:
  //           print(e.message);
  //           throw ("Error en el POST");
  //           break;
  //         default:
  //       }
  //     },
  //   ));
  // }

  static void configureDio() {
    //Base url
    _dio.options.baseUrl = "http://mp.tipre.com:8080/api/v1";
    //MODIFICACION : Retorna url de produccion o desarrollo en base al enviroment(config.dart)
    // _dio.options.baseUrl = apiHost;

    // Configurar Headers
    // como puede que no lo tengamos en ese momento retorna un string vacio

    //CAMBIAR X-TOKEN POR Authorization: ver Postman get-users endpoint en headers
    _dio.options.headers = {
      // 'Authorization': LocalStorage.prefs.getString("token") ?? "",
      // mi codigo: error falta concatenar el bearer
      // 'Authorization': "LocalStorage.prefs.getString("token") ?? "",
      'Authorization': "Bearer ${LocalStorage.prefs.getString("token") ?? ''}",
    };
  }

  // ejemplo del path : /usuarios, /categorias
  static Future httpGet(String path) async {
    try {
      final response = await _dio.get(path);

      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ("Error en el GET");
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    // final formData = FormData.fromMap(data);
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ("Error en el POST");
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el PUT $e');
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el delete');
    }
  }

  // metodo para imagenes

  static Future uploadFile(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({"archivo": MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.put(
        path,
        data: formData,
      );

      return resp.data;
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el PUT $e');
    }
  }
}
