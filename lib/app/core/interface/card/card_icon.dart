import 'package:flutter/material.dart';

import '../../colors/colors_app.dart';

class CardIcon extends StatelessWidget {
  const CardIcon({
    super.key,
    required this.icon,
    this.radius,
    this.height,
    this.width,
    this.color,
  });

  final IconData icon;
  final double? radius;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 10),
        ),
      ),
      color: color ?? ColorApp.primary,
      child: SizedBox(
        height: height ?? 40,
        width: width ?? 40,
        child: Center(
          child: Icon(
            icon,
            color: ColorApp.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
