import 'package:admin_dashboard/ui/views/user_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/side_menu_provider.dart';

import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/categories_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/users_view.dart';

class DashboardHandlers {
  //DASHBOARD VIEW
  //pagina principal(main)
  static Handler dashboard = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });

  //ICONS VIEW
  static Handler icons = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.iconsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const IconsView();
    } else {
      return const LoginView();
    }
  });

  //BLANK VIEW
  static Handler blank = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.blankRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return const LoginView();
    }
  });

  //CATEGORIES
  static Handler categories = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.categoriesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CategoriesView();
    } else {
      return const LoginView();
    }
  });

  //USERS
  static Handler users = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UsersView();
    } else {
      return const LoginView();
    }
  });

  //USER
  static Handler user = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(parameters);
      // checkea si tengo el uid en el parametro
      if (parameters['uid']?.first != null) {
        // retorna la vista con el uid  correspondiente via constructor
        return UserView(id: parameters['uid']!.first);
      }
    } else {
      return const UsersView();
    }
  });
}
