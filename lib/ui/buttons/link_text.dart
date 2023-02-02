import 'package:flutter/material.dart';

class LinkText extends StatefulWidget {
  final String text;
  // es opcional
  final Function? onPressed;

  const LinkText({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          // siempre lo voy a tener porque estoy chekeando previamente si
          // la propiedad es nula( en esta caso una funcion)
          widget.onPressed!();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                decoration:
                    isHover ? TextDecoration.underline : TextDecoration.none),
          ),
        ),
      ),
    );
  }
}

// MouseRegion:es un widget con diferentes eventos
// se utiliza para hacer el hover
// propiedad cursor: muestra la flecha unicamente
// GestureDetector: para aplicar la funcionalidad del click del widget
// mediante la propiedad onTap
