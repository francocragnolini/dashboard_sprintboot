import 'package:admin_dashboard/providers/side_menu_provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/shared/widgtes/navbar_avatar.dart';
import 'package:admin_dashboard/ui/shared/widgtes/notifications_indicator.dart';
import 'package:admin_dashboard/ui/shared/widgtes/search_text.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 50,
      decoration: _buildBoxDecoration(),
      child: Row(
        children: [
          //rendering condicional
          // si quiero mostrar o no mas de un elemento condicionalmente
          // if (size.width <= 700) ...[
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.menu_outlined)),
          //   const SizedBox(width: 5),
          // ],
          if (size.width <= 700)
            IconButton(
                onPressed: () {
                  SideMenuProvider.openMenu();
                },
                icon: const Icon(Icons.menu_outlined)),

          const SizedBox(width: 5),

          //search input
          if (size.width > 390)
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 250,
              ),
              child: const SearchText(),
            ),

          const Spacer(),

          const NotificationsIndicator(),

          const SizedBox(width: 10),

          const NavbarAvatar(),

          const SizedBox(width: 10),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      );
}
