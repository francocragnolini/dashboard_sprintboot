import 'dart:developer';

import 'package:flutter/material.dart';

// api
import 'package:admin_dashboard/api/cafe_api.dart';

// models
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Categoria> categories = [];

  getCategories() async {
    // get a la api cafe
    final response = await CafeApi.httpGet("/categorias");

    // mapeando la respuesta obtenida
    final categoriesResponse = CategoriesResponse.fromMap(response);

    // asignandole el valor a categorias

    categories = [...categoriesResponse.categorias];

    print(categories);

    notifyListeners();
  }

  Future newCategory(String name) async {
    final data = {
      "nombre": name,
    };

    try {
      final json = await CafeApi.post("/categorias", data);
      final newCategory = Categoria.fromMap(json);

      categories.add(newCategory);

      notifyListeners();
    } catch (e) {
      log(e.toString());
      log("Error al crear cateogria");
      throw "Error al crear cateogria";
    }
  }

  Future updateCategory(String id, String name) async {
    final data = {'nombre': name};

    try {
      await CafeApi.put('/categorias/$id', data);

      categories = categories.map((category) {
        if (category.id != id) return category;
        category.nombre = name;
        return category;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar categoria';
    }
  }

  Future deleteCategory(String id) async {
    try {
      await CafeApi.delete('/categorias/$id', {});

      categories.removeWhere((categoria) => categoria.id == id);

      notifyListeners();
    } catch (e) {
      log(e.toString());
      throw "Error al borrar categoria";
    }
  }
}
