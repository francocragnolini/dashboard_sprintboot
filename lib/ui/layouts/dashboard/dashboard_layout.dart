import 'package:admin_dashboard/providers/side_menu_provider.dart';
import 'package:admin_dashboard/ui/shared/navbar.dart';
import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';

class DashBoardLayout extends StatefulWidget {
  // recibe un child para mostrar la vista correspondiente
  final Widget child;
  const DashBoardLayout({super.key, required this.child});

  @override
  State<DashBoardLayout> createState() => _DashBoardLayoutState();
}

class _DashBoardLayoutState extends State<DashBoardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              //  rendering condicional
              if (size.width >= 700) const Sidebar(),

              Expanded(
                child: Column(
                  children: [
                    //Navbar
                    const Navbar(),

                    //View
                    Expanded(
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // para mobile
          if (size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) {
                // usa un stack porque debe colocar el background o overlay por debajo del sidebar
                return Stack(
                  children: [
                    // background del sidebar
                    if (SideMenuProvider.isOpen)
                      Opacity(
                        opacity: SideMenuProvider.opacity.value,
                        child: GestureDetector(
                          onTap: () => SideMenuProvider.closeMenu(),
                          child: Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.black26,
                          ),
                        ),
                      ),

                    Transform.translate(
                      offset: Offset(SideMenuProvider.movement.value, 0),
                      child: const Sidebar(),
                    )
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
