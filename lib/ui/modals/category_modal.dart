import 'dart:developer';

import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/models/category.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class CategoryModal extends StatefulWidget {
  // recibo la categoria para crear o editarla
  // es opcional : porque en el caso de crear una nueva no tengo ninguna categoria,
  // solamente  voy a tener una catgoria cuando quiera editar una existente
  final Categoria? category;

  const CategoryModal({super.key, this.category});

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String nombre = "";
  String? id;

  @override
  void initState() {
    id = widget.category?.id;
    nombre = widget.category?.nombre ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300,
      decoration: _buildBoxDecoration(), // por defecto es expanded
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.category?.nombre ?? "Nueva Categoria",
                style: CustomLabels.h1.copyWith(color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ))
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.3),
          ),
          TextFormField(
            initialValue: widget.category?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: "Nombre de la categoria",
                label: "Categoria",
                icon: Icons.new_releases_outlined),
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                log(nombre);
                try {
                  if (id == null) {
                    // crear
                    await categoriesProvider.newCategory(nombre);
                    NotificationsService.showSnackbar("$nombre creada!!");
                  } else {
                    //Actualizar
                    //CafeAPI:crear metodo statico similar al post
                    //CategoriesProvider:Crear metodo updateCategories(String id, String nombre)
                    //CategoriesProvider: actualizar unicamente la categoria que su nombre cambio
                    //NotifyListeners para que los cambios se vean refelajdos en la tabla
                    await categoriesProvider.updateCategory(id!, nombre);
                    NotificationsService.showSnackbar("$nombre actualizada!!");
                  }
                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError(
                      "No se pudo guardar la categoria");
                }
              },
              text: "Guardar",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Color(0xff0F2041),
          boxShadow: [
            BoxShadow(color: Colors.black26),
          ]);
}
