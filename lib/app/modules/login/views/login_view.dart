import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Admin',
          style: TextStyle(color: ColorApp.black),
        ),
        elevation: 0,
        backgroundColor: ColorApp.white.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 20.sH,
                // const FlutterLogo(size: 120),
                40.sH,
                TextForm.isTitle(
                  controller: controller.usernameC,
                  title: 'Username',
                  hintText: 'Username',
                  isBorder: true,
                  colorFocusBorder: ColorApp.primary,
                  colorBorder: ColorApp.black.withOpacity(0.6),
                  labelColor: ColorApp.black.withOpacity(0.6),
                  isCheck: true,
                ),
                16.sH,
                Obx(
                  () => TextForm.isTitle(
                    controller: controller.passC,
                    title: 'Password',
                    hintText: 'Password',
                    isBorder: true,
                    colorFocusBorder: ColorApp.primary,
                    colorBorder: ColorApp.black.withOpacity(0.6),
                    labelColor: ColorApp.black.withOpacity(0.6),
                    obscureText: controller.isObscure.value,
                    suffixIcon: iconVisible(),
                    isCheck: true,
                  ),
                ),
                20.sH,
                Obx(
                  () => ButtonPrymary(
                    isLoading: controller.isLoading.value,
                    text: 'Login',
                    onPressed: controller.login,
                    height: 50,
                  ),
                ),
                30.sH,
                const Text(
                  'info : ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                4.sH,
                const Text(
                  'Login menggunakan akun yang sudah di daftarkan oleh panitia',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell iconVisible() {
    return InkWell(
      onTap: controller.initObscure,
      child: Icon(
        controller.isObscure.value == true
            ? Icons.visibility
            : Icons.visibility_off,
        color: ColorApp.primary,
      ),
    );
  }
}
