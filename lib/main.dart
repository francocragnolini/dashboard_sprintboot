import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/api/cafe_api.dart';

import 'package:admin_dashboard/router/router.dart';

// import 'package:admin_dashboard/providers/users_provider.dart';
// import 'package:admin_dashboard/providers/auth_provider.dart';
// import 'package:admin_dashboard/providers/categories_provider.dart';
// import 'package:admin_dashboard/providers/side_menu_provider.dart';
// import 'package:admin_dashboard/providers/user_form_provider.dart';

import 'package:admin_dashboard/providers/providers.dart';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';

void main() async {
  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => SideMenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserFormProvider(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Dashboard',
        initialRoute: "/", // "/" or Flurorouter.rootRoute
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        scaffoldMessengerKey: NotificationsService.messengerKey,
        builder: (_, child) {
          //Aqui si ya se tiene el token se puede reidirgir a la pantalla de dashboard
          //o a la pantalla del login dependiendo del caso
          // print(LocalStorage.prefs.getString('token'));

          final authProvider = Provider.of<AuthProvider>(context);

          if (authProvider.authStatus == AuthStatus.checking) {
            return const SplashLayout();
          }
          if (authProvider.authStatus == AuthStatus.authenticated) {
            return DashBoardLayout(child: child!);
          } else {
            // Idea Mia
            // return AuthLayout(child: child ?? Container(child:Text("View not Found"));
            return AuthLayout(child: child!);
          }
        },

        // aplica al scroll-bar el color blanco
        theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5))),
        ));
  }
}


//1 carpeta router
//-file router: routes declarations
//-file handlers: logic of the routes, return views
//2  in main.dart
//a- inicialize the route Flurorouter.configureRoutes()
//b- delete home
//c- declare initialRoute
//d- declare onGenerateRoute : Flurorouter.router.generator
//e- declare builder: (cpntext,child) {}
// este builder debe regresar un Widget, en este caso un Layout
// el layout recibe un child 
// pasa via constructor al layout
// y del layout al desktop
// y el desktop renderiza la vista de LoginView


//NavigatorKey = permite navegar y caombiar los layouts