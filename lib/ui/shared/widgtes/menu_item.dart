import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemSidebar extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  const MenuItemSidebar(
      {super.key,
      required this.text,
      required this.icon,
      // para cuando ya este en la seccion no pueda hacer click nuevamente(me quede seleccionado)
      this.isActive = false,
      required this.onPressed});

  @override
  State<MenuItemSidebar> createState() => _MenuItemSidebarState();
}

class _MenuItemSidebarState extends State<MenuItemSidebar> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered
          ? Colors.white.withOpacity(0.1)
          : widget.isActive
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: MouseRegion(
              onEnter: (event) => setState(() {
                isHovered = true;
              }),
              onExit: (event) {
                setState(() {
                  isHovered = false;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.text,
                    style: GoogleFonts.roboto(
                        fontSize: 16, color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
