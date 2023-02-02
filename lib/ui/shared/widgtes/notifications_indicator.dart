import 'package:flutter/material.dart';

class NotificationsIndicator extends StatelessWidget {
  const NotificationsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        const Icon(
          Icons.notification_add_outlined,
          color: Colors.grey,
        ),
        Positioned(
          left: 5,
          child: Container(
            width: 5,
            height: 5,
            decoration: _buildBoxDecoration(),
          ),
        )
      ]),
    );
  }

  BoxDecoration _buildBoxDecoration() =>
      BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5));
}
