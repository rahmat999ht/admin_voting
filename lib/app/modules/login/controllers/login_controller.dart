import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_actions.dart';
import '../../../core/interface/alerts/alert_info.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameC = TextEditingController();
  final passC = TextEditingController();
  final isLoading = false.obs;
  final isObscure = true.obs;

  void initLoading() {
    isLoading.value = !isLoading.value;
  }

  void initObscure() {
    isObscure.value = !isObscure.value;
  }

  Future login() async {
    initLoading();
    try {
      if (formKey.currentState!.validate()) {
        final admin = ConstansApp.firestore.collection(
          ConstansApp.adminCollection,
        );
        await iniData(admin);
      }
    } catch (e) {
      alertInfo('info', 'pesan error : $e');
    }
    initLoading();
  }

  Future iniData(
    CollectionReference<Map<String, dynamic>> collection,
  ) async {
    final data = await collection
        .where('username', isEqualTo: usernameC.text)
        .where('pass', isEqualTo: passC.text)
        .get();
    if (data.size == 0) {
      log("data 0");
      alertGagal();
      return;
    } else {
      log("try : ${data.docs.first.id}");
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("idLogin", data.docs.first.id);
      Get.offAllNamed(
        Routes.DASHBOARD,
      );
    }
  }

  alertGagal() {
    alertActions(
      'Info',
      'akun tidak di temukan',
      [
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Get.back(result: false);
            // Get.back();
          },
        ),
      ],
    );
  }
}
