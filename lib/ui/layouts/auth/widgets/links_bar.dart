import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      width: double.infinity,
      //hace referencia a la media query del authLayout
      // height: size.height * 0.075,
      height: (size.width > 1000) ? size.height * 0.085 : null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText(
            text: "About",
            onPressed: () {
              print("About");
            },
          ),
          LinkText(text: "Help Center"),
          LinkText(text: "Privacy Policy"),
          LinkText(text: "Cookie Policy"),
          LinkText(text: "Ads Info"),
          LinkText(text: "BLog"),
          LinkText(text: "Status"),
          LinkText(text: "Careers"),
          LinkText(text: "Brand Resources"),
          LinkText(text: "Advertising"),
          LinkText(text: "Marketing"),
        ],
      ),
    );
  }
}


//Wrap: es parecido a un listView: 
// es muy parecido a un div con ciertas propiedades de un flexbox
