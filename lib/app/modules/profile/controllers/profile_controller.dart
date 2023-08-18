import 'dart:developer';
import 'dart:io';

import 'package:admin_voting/app/core/models/admin.dart';
import 'package:admin_voting/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/button/button_outline.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_content.dart';
import '../../../core/services/method.dart';
import '../../form_capres/controllers/image_controller.dart';

class ProfileController extends GetxController {
  AdminModel? dataAdmin = Get.arguments;
  final methodApp = MethodApp();
  final isLoading = false.obs;

  String idAdmin = '';

  final formKey = GlobalKey<FormState>();
  final cNama = TextEditingController();
  final cNoHp = TextEditingController();
  final cJkl = TextEditingController();

  void initLoading() {
    isLoading.value = !isLoading.value;
  }

  final dC = Get.find<DashboardController>();

  Future save() async {
    initLoading();
    try {
      if (formKey.currentState!.validate()) {
        final dataImage = Get.find<ImagesController>();
        if (dataImage.imageFileList.isNotEmpty ||
            dataAdmin!.foto != null ||
            dataAdmin!.foto != '') {
          if (dataImage.imageFileList.isNotEmpty) {
            log('masuk');
            log(' image : ${dataImage.imageFileList.length}');
            final foto = await methodApp.uploadWithImage(
              File(dataImage.imageFileList.first.path),
              "${ConstansApp.idLogin}_${DateTime.now().toIso8601String()}",
            );
            final data = AdminModel(
              foto: foto,
              nama: cNama.text,
              jkl: cJkl.text,
              noHp: cNoHp.text,
            ).toUpdateImage();
            methodApp.updateAdmin(
              idAdmin: idAdmin,
              data: data,
            );
            var dataToMap = AdminModel(
              foto: foto,
              nama: cNama.text,
              jkl: cJkl.text,
              noHp: cNoHp.text,
              pass: dataAdmin!.pass,
              userName: dataAdmin!.userName,
            ).toMap();
            final dataSucces = AdminModel.fromMapById(idAdmin, dataToMap);
            dC.successState(dataSucces);

            Get.back();

            log('masuk 1 ${dataImage.imageFileList.length}');
          } else {
            final data = AdminModel(
              nama: cNama.text,
              jkl: cJkl.text,
              noHp: cNoHp.text,
            ).toUpdateNoImage();
            methodApp.updateAdmin(
              idAdmin: idAdmin,
              data: data,
            );
            var dataToMap = AdminModel(
              foto: dataAdmin!.foto,
              nama: cNama.text,
              jkl: cJkl.text,
              noHp: cNoHp.text,
              pass: dataAdmin!.pass,
              userName: dataAdmin!.userName,
            ).toMap();
            final dataSucces = AdminModel.fromMapById(idAdmin, dataToMap);
            dC.successState(dataSucces);
            Get.back();
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
    initLoading();
  }

  Future alertJKL() async {
    return await alertContent(
      title: 'Jenis kelamin',
      content: Column(
        children: [
          ButtonOutline(
            text: 'Laki-Laki',
            colorBorder: Colors.black87,
            fontColor: Colors.black87,
            onPressed: () {
              cJkl.text = 'Laki-Laki';
              Get.back();
            },
          ),
          ButtonOutline(
            text: 'Perempuan',
            colorBorder: Colors.black87,
            fontColor: Colors.black87,
            onPressed: () {
              cJkl.text = 'Perempuan';
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    if (dataAdmin == null) {
      idAdmin = '';
      cNama.text = '';
      cNoHp.text = '';
      cJkl.text = '';
    } else {
      idAdmin = dataAdmin!.id!;
      cNama.text = dataAdmin!.nama!;
      cNoHp.text = dataAdmin!.noHp!;
      cJkl.text = dataAdmin!.jkl!;
    }
    super.onInit();
  }
}
