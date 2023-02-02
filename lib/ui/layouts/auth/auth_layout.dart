import 'package:admin_dashboard/ui/layouts/auth/widgets/background_twitter.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/custom_title.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/links_bar.dart';
import 'package:flutter/material.dart';

// se retorna en el main.dart en el builder
class AuthLayout extends StatelessWidget {
  //1- recibe la vista desde el main via constructor
  final Widget child;
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      //agrega un scroll bar
      body: Scrollbar(
        // thumbVisibility: true,
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            // 2- pasa la vista a desktop o mobile basado en el width
            (size.width > 1000)
                ? _DesktopBody(child: child)
                : _MobileBody(child: child),

            const LinksBar(),
          ],
        ),
      ),
    );
  }
}

// VISTA MOBILE
class _MobileBody extends StatelessWidget {
  final Widget child;
  const _MobileBody({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CustomTitle(),
          Container(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          // PROBLEMA CON EL EXPANDED
          // SOLUCION 1:
          Container(
            width: double.infinity,
            // height: 420,
            child: const BackgroundTwitter(),
          ),
        ],
      ),
    );
  }
}

// VISTA DESKTOP
class _DesktopBody extends StatelessWidget {
  // recibe la vista
  final Widget child;

  const _DesktopBody({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.95,
      color: Colors.red,
      child: Row(
        children: [
          // Twitter background
          // columna responsive
          // expanded toma todo el espacio disponible
          const Expanded(child: BackgroundTwitter()),

          // View Container : aqui va a venir la vista basada en el url
          // columna estatica
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            // the view la vista
            child: Column(
              children: [
                const CustomTitle(),
                const SizedBox(
                  height: 20,
                ),
                // la vista propiamente dicha
                // renderiza la vista
                Expanded(child: child),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//Auth Layout
// Es una Pagina Contiene un Scaffold
// retorna un listView: que va a contener los diseños:
//desktop y mobile
// Linksbar

// Aclaracion: como estamos trabajando con un ListView, debe tener un tamaño fijo.
// por lo tanto el container debe tener un tamaño especifico
// si estamos dentro de un ListView sus hijos tiene que tener un cierto tamaño
