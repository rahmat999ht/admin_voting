import 'dart:developer';
import 'dart:io';

import 'package:admin_voting/app/modules/form_capres/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/button/button_outline.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_content.dart';
import '../../../core/interface/alerts/alert_info.dart';
import '../../../core/models/capres.dart';
import '../../../core/services/method.dart';

class FormCapresController extends GetxController {
  CapresModel? dataCapres = Get.arguments['data'];
  int? lengthCapres = Get.arguments['length'];
  final methodApp = MethodApp();
  final isLoading = false.obs;

  String title = '';
  String noUrut = '';

  final formKey = GlobalKey<FormState>();
  final cNoUrut = TextEditingController();
  final cNama = TextEditingController();
  final cStb = TextEditingController();
  final cJkl = TextEditingController();
  final cProdi = TextEditingController();

  RxList<TextEditingController> listFormVisi = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
  ].obs;

  RxList<TextEditingController> listFormMisi = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
  ].obs;

  void addFormVisi() {
    listFormVisi.add(
      TextEditingController(),
    );
  }

  void deleteFormVisi(e) {
    listFormVisi.remove(e);
  }

  void addFormMisi() {
    listFormMisi.add(
      TextEditingController(),
    );
  }

  void deleteFormMisi(e) {
    listFormMisi.remove(e);
  }

  void initLoading() {
    isLoading.value = !isLoading.value;
  }

  Future tambahCapres() async {
    initLoading();
    try {
      if (formKey.currentState!.validate()) {
        final dataImage = Get.find<ImagesController>();
        final List<String> listVisi = listFormVisi.map((e) => e.text).toList();
        final List<String> listMisi = listFormMisi.map((e) => e.text).toList();
        if (dataImage.imageFileList.isNotEmpty) {
          log('masuk');
          log(' image : ${dataImage.imageFileList.length}');
          final foto = await methodApp.uploadWithImage(
            File(dataImage.imageFileList.first.path),
            "${ConstansApp.idLogin}_${DateTime.now().toIso8601String()}",
          );
          final data = CapresModel(
            foto: foto,
            noUrut: noUrut,
            stb: int.parse(cStb.text),
            nama: cNama.text,
            jkl: cJkl.text,
            prody: cProdi.text,
            pass: 'm${cStb.text}',
            visi: listVisi,
            misi: listMisi,
          ).toAddImage();
          methodApp.addCapres(data: data);
          Get.back();
          alertInfo(
            'info',
            'Berhasil menambahkan capres baru',
          );
          log('masuk 1 ${dataImage.imageFileList.length}');
        } else {
          Get.snackbar('Info', "Tolong tambahkan Image");
        }
      }
    } catch (e) {
      log(e.toString());
    }
    initLoading();
  }

  Future editCapres(String id) async {
    initLoading();
    try {
      if (formKey.currentState!.validate()) {
        final dataImage = Get.find<ImagesController>();
        final List<String> listVisi = listFormVisi.map((e) => e.text).toList();
        final List<String> listMisi = listFormMisi.map((e) => e.text).toList();
        if (dataImage.imageFileList.isNotEmpty ||
            dataCapres!.foto != null ||
            dataCapres!.foto != '') {
          if (dataImage.imageFileList.isNotEmpty) {
            log('masuk');
            log(' image : ${dataImage.imageFileList.length}');
            final foto = await methodApp.uploadWithImage(
              File(dataImage.imageFileList.first.path),
              "${ConstansApp.idLogin}_${DateTime.now().toIso8601String()}",
            );
            final data = CapresModel(
              foto: foto,
              stb: int.parse(cStb.text),
              nama: cNama.text,
              jkl: cJkl.text,
              prody: cProdi.text,
              visi: listVisi,
              misi: listMisi,
            ).toUpdateImage();
            methodApp.updateCapres(
              idCapres: id,
              data: data,
            );
            Get.back();
            alertInfo(
              'info',
              'Berhasil mengedit capres ${cNama.text}',
            );
            log('masuk 1 ${dataImage.imageFileList.length}');
          } else {
            final data = CapresModel(
              stb: int.parse(cStb.text),
              nama: cNama.text,
              jkl: cJkl.text,
              prody: cProdi.text,
              visi: listVisi,
              misi: listMisi,
            ).toUpdate();
            methodApp.updateCapres(
              idCapres: id,
              data: data,
            );
            Get.back();
            alertInfo(
              'info',
              'Berhasil mengedit capres ${cNama.text}',
            );
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

  Future alertProdi() async {
    return await alertContent(
      title: 'Program Studi',
      content: Column(
        children: [
          ButtonOutline(
            text: 'Sistem Informasi',
            colorBorder: Colors.black87,
            fontColor: Colors.black87,
            onPressed: () {
              cProdi.text = 'Sistem Informasi';
              Get.back();
            },
          ),
          ButtonOutline(
            text: 'Teknik Informatika',
            colorBorder: Colors.black87,
            fontColor: Colors.black87,
            onPressed: () {
              cProdi.text = 'Teknik Informatika';
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    String initialString = (lengthCapres! + 1).toString();
    noUrut = initialString.padLeft(2, '0');
    if (dataCapres == null) {
      title = 'Tambah Capres';
      cNama.text = '';
      cStb.text = '';
      cJkl.text = '';
      cProdi.text = '';
    } else {
      title = 'Edit Capres';
      dataCapres = Get.arguments['data'];
      cNoUrut.text = dataCapres!.noUrut!;
      cNama.text = dataCapres!.nama!;
      cStb.text = dataCapres!.stb.toString();
      cJkl.text = dataCapres!.jkl!;
      cProdi.text = dataCapres!.prody!;
      if (dataCapres!.visi!.isEmpty || dataCapres!.visi == null) {
        listFormVisi.length = 2;
      } else {
        listFormVisi.value = dataCapres!.visi!
            .map(
              (e) => TextEditingController(text: e.toString()),
            )
            .toList();
      }
      if (dataCapres!.misi!.isEmpty || dataCapres!.misi == null) {
        listFormMisi.length = 2;
      } else {
        listFormMisi.value = dataCapres!.misi!
            .map(
              (e) => TextEditingController(text: e.toString()),
            )
            .toList();
      }
    }
    super.onInit();
  }
}
