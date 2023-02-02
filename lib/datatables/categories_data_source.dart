import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:developer';

import 'package:admin_dashboard/providers/categories_provider.dart';

import 'package:admin_dashboard/models/category.dart';

import 'package:admin_dashboard/ui/modals/category_modal.dart';

class CategoriesDTS extends DataTableSource {
  final List<Categoria> categories;
  final BuildContext context;

  CategoriesDTS(this.categories, this.context);
  @override
  // como se construye una fila
  DataRow getRow(int index) {
    // si son 4 columnas(ej:DataColumn(label: Text("id")),), debe tener al menos 4 rows(DataCell(child),)
    final category = categories[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(category.id)),
        DataCell(Text(category.nombre)),
        DataCell(Text(category.usuario.nombre)),
        //acciones crud
        DataCell(Row(
          children: [
            IconButton(
                onPressed: () {
                  log("Edintando: $category");
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => CategoryModal(
                      category: category,
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined)),
            IconButton(
                onPressed: () {
                  log("Borrando: $category");
                  final dialog = AlertDialog(
                    title: const Text("¿Estas seguro de borrarlo?"),
                    content: Text("Borrar definitivamente ${category.nombre}"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Provider.of<CategoriesProvider>(context,
                                  listen: false)
                              .deleteCategory(category.id);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Si, borrar"),
                      ),
                    ],
                  );

                  showDialog(
                    context: context,
                    builder: (context) {
                      return dialog;
                    },
                  );
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8),
                )),
          ],
        )),
      ],
    );
  }

  @override
  //isRowCountApproximate: Cuando no se tiene exactamente el numero de columnas
  bool get isRowCountApproximate => false;

  @override
  // cuantos elementos tengo en el data table
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
}
