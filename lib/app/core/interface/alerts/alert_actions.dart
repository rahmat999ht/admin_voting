import 'package:flutter/material.dart';
import 'package:get/get.dart';

alertActions(
  String title,
  String middleText,
  List<Widget>? actions,
) {
  Get.defaultDialog(
    title: title,
    middleText: middleText,
    radius: 8,
    actions: actions,
  );
}
