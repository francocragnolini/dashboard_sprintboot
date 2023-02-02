import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

// es la base de la vista del panel administrativo
// es un cascaron para recordarme el dia de mañana si quiero crear una nueva vista esta es la base del panel administrativo
class BlankView extends StatelessWidget {
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            "Blank View",
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 20),

          //Contenedor para mostrar contenido en las vistas
          const WhiteCard(
            // title: "Sales Statistics",
            child: Text("Hola Mundo"),
          ),
        ],
      ),
    );
  }
}
