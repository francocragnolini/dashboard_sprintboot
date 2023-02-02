import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

// es la base de la vista del panel administrativo
// es un cascaron para recordarme el dia de mañana si quiero crear una nueva vista esta es la base del panel administrativo
class IconsView extends StatelessWidget {
  const IconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            "Icons View",
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 20),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: const [
              WhiteCard(
                width: 170,
                title: "ac_unit_outlined",
                child: Center(
                  child: Icon(Icons.ac_unit_outlined),
                ),
              ),
              WhiteCard(
                width: 170,
                title: "access_alarm_outlined",
                child: Center(
                  child: Icon(Icons.access_alarm_outlined),
                ),
              ),
              WhiteCard(
                width: 170,
                title: "access_time_rounded",
                child: Center(
                  child: Icon(Icons.access_time_rounded),
                ),
              ),
              WhiteCard(
                width: 170,
                title: "all_inbox_outlined",
                child: Center(
                  child: Icon(Icons.all_inbox_outlined),
                ),
              ),
              WhiteCard(
                width: 170,
                title: "desktop_mac_outlined",
                child: Center(
                  child: Icon(Icons.desktop_mac_outlined),
                ),
              ),
              WhiteCard(
                width: 170,
                title: "keyboard_alt_rounded",
                child: Center(
                  child: Icon(Icons.keyboard_alt_rounded),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
