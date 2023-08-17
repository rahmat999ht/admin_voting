import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../colors/colors_app.dart';

AppBar appBarBack({
  required String title,
}) {
  return AppBar(
    elevation: 0,
    centerTitle: false,
    toolbarHeight: 70,
    automaticallyImplyLeading: false,
    backgroundColor: ColorApp.white.withOpacity(0),
    title: Row(
      children: [
        20.sH,
        InkWell(
          onTap: Get.back,
          child: Card(
            // margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: ColorApp.primary),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorApp.black,
                  ),
                  3.sW,
                ],
              ),
            ),
          ),
        ),
        8.sW,
        Text(
          title,
          style: TextStyle(
            color: ColorApp.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
