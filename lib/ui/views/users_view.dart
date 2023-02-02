import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/users_provider.dart';

import 'package:admin_dashboard/datatables/users_data_source.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';

// el lbank view sirve para crear rapidamente nuestras vistas
// es la base de la vista del panel administrativo
// es un cascaron para recordarme el dia de mañana si quiero crear una nueva vista esta es la base del panel administrativo
class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final usersDataSource = UsersDataSource(usersProvider.users);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            "Users View",
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 20),
          PaginatedDataTable(
            sortAscending: usersProvider.ascending,
            sortColumnIndex: usersProvider.sortColumnIndex,
            columns: [
              const DataColumn(label: Text("Avatar")),
              DataColumn(
                label: const Text("Nombre"),
                onSort: (columnIndex, _) {
                  usersProvider.sortColumnIndex = columnIndex;
                  usersProvider.sort<String>(
                    (user) => user.username,
                  );
                },
              ),
              DataColumn(
                label: const Text("Email"),
                onSort: (columnIndex, _) {
                  usersProvider.sortColumnIndex = columnIndex;
                  usersProvider.sort<String>(
                    (user) => user.correo,
                  );
                },
              ),
              const DataColumn(label: Text("ID")),
              const DataColumn(label: Text("Acciones")),
            ],
            source: usersDataSource,
            onPageChanged: (page) {
              print("page: $page");
            },
          ),
        ],
      ),
    );
  }
}

// ordenar una columna
//DataColumn: onSort: (columnIndex, ascending) {},
//columnIndex:  indica cual es el indice de la columna que se quiere ordenar
// metodo onPageChanged: