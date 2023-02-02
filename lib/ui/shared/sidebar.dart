import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/side_menu_provider.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/services/navigation_service.dart';

import 'package:admin_dashboard/ui/shared/widgtes/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgtes/text_separator.dart';
import 'package:admin_dashboard/ui/shared/widgtes/logo.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void navigateTo(
    String routeName,
  ) {
    // NavigationService.navigateTo(routeName);
    NavigationService.replaceTo(routeName);

    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: _buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(
            height: 50,
          ),

          // este widget todavia no existe clase 106
          const TextSeparator(text: 'main'),
          MenuItemSidebar(
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
              text: "Dashboard",
              icon: Icons.compass_calibration_outlined,
              onPressed: () {
                navigateTo(Flurorouter.dashboardRoute);
              }),

          MenuItemSidebar(
            text: "Orders",
            icon: Icons.shopping_cart_outlined,
            onPressed: () {},
          ),

          MenuItemSidebar(
            text: "Analitycs",
            icon: Icons.show_chart_outlined,
            onPressed: () {},
          ),

          MenuItemSidebar(
            isActive:
                sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
            text: "Categories",
            icon: Icons.layers_outlined,
            onPressed: () => navigateTo(Flurorouter.categoriesRoute),
          ),

          MenuItemSidebar(
            text: "Products",
            icon: Icons.dashboard_outlined,
            onPressed: () {},
          ),

          MenuItemSidebar(
            text: "Discount",
            icon: Icons.attach_money_outlined,
            onPressed: () {},
          ),

          MenuItemSidebar(
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
            text: "Users",
            icon: Icons.people_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.usersRoute),
          ),

          const SizedBox(
            height: 30,
          ),

          const TextSeparator(text: 'UI Elements'),

          MenuItemSidebar(
            isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
            text: "Icons",
            icon: Icons.list_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.iconsRoute),
          ),

          MenuItemSidebar(
            text: "Marketing",
            icon: Icons.mark_email_read_outlined,
            onPressed: () {},
          ),

          MenuItemSidebar(
            text: "Campaign",
            icon: Icons.note_add_outlined,
            onPressed: () {},
          ),
          MenuItemSidebar(
            isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
            text: "BLank",
            icon: Icons.post_add_outlined,
            onPressed: () => navigateTo(Flurorouter.blankRoute),
          ),

          const SizedBox(
            height: 50,
          ),

          const TextSeparator(text: 'Exit'),

          MenuItemSidebar(
            text: "Logout",
            icon: Icons.exit_to_app_outlined,
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff092044),
          Color(0xff092042),
        ]),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      );
}
