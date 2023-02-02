import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'package:admin_dashboard/datatables/categories_data_source.dart';

import 'package:admin_dashboard/providers/categories_provider.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/buttons/custom_button_icon.dart';

// es la base de la vista del panel administrativo
// es un cascaron para recordarme el dia de mañana si quiero crear una nueva vista esta es la base del panel administrativo
class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  // modificar la cantidad de elementos por pagina: como es propio de la vista usa stateful widget
  // la paginacion solo importa en esta vista
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    // Provider.of<CategoriesProvider>(context, listen: false).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoriesProvider>(context).categories;
    if (categories.isEmpty) {
      return const WhiteCard(child: Text("No Hay categorias"));
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Text(
              "Categorias Titulo",
              style: CustomLabels.h1,
            ),
            const SizedBox(height: 20),

            //Contenedor para mostrar contenido en las vistas
            PaginatedDataTable(
              columns: const [
                DataColumn(label: Text("id")),
                DataColumn(label: Text("Categoria")),
                DataColumn(label: Text("Creado por")),
                DataColumn(label: Text("Acciones")),
              ],
              source: CategoriesDTS(categories, context),
              header: const Text(
                "Categorias disponibles",
                maxLines: 2,
              ),
              // permite al usuario cambiar la cantidad de elementos por pagina
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value!;
                });
                log(value.toString());
              },
              //cantidad de elementos por pagina
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => const CategoryModal(
                        category: null,
                      ),
                    );
                  },
                  text: "Crear",
                  icon: Icons.add_outlined,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}


//TABLA: PARA REALIZAR UN CRUD
//WIDGET: PaginatedDataTable()
//ARGUMENTOS:columns: [],source: ,
// columns: [ DataColumn(label: label),]: el label es un widget 