import 'package:flutter/material.dart';
import 'package:packages/extensions/size_app.dart';

import '../../../core/colors/colors_app.dart';

class CardHome extends StatelessWidget {
  const CardHome({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: ColorApp.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 70,
                color: ColorApp.primary,
              ),
            ),
          ),
        ),
        8.sH,
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: ColorApp.white,
          ),
        ),
      ],
    );
  }
}
