import 'package:admin_voting/app/core/interface/alerts/alert_content.dart';
import 'package:admin_voting/app/core/models/pemilih.dart';
import 'package:admin_voting/app/core/services/method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/button/button_outline.dart';

class FormPemilihController extends GetxController {
  PemilihModel? dataPemilih = Get.arguments;
  final methodApp = MethodApp();
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final cNama = TextEditingController();
  final cStb = TextEditingController();
  final cJkl = TextEditingController();
  final cProdi = TextEditingController();

  String title = '';

  void initLoading() {
    isLoading.value = !isLoading.value;
  }

  void tambahPemilih() {
    initLoading();
    final data = PemilihModel(
      stb: int.parse(cStb.text),
      nama: cNama.text,
      pass: 'm${cStb.text}',
      isAktif: true,
      isMemilih: false,
    ).toAdd();
    methodApp.addPemilih(data: data);
    Get.back();
    initLoading();
  }

  void editPemilih(String id) {
    initLoading();
    final data = PemilihModel(
      stb: int.parse(cStb.text),
      nama: cNama.text,
    ).toUpdate();
    methodApp.updatePemilih(
      idPemilih: id,
      data: data,
    );
    Get.back();
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
          ButtonOutline(
            text: 'Rekayasa Perangkat Lunak',
            colorBorder: Colors.black87,
            fontColor: Colors.black87,
            onPressed: () {
              cProdi.text = 'Rekayasa Perangkat Lunak';
              Get.back();
            },
          ),
          ButtonOutline(
            text: 'Bisnis Digital',
            colorBorder: Colors.black87,
            fontColor: Colors.black87,
            onPressed: () {
              cProdi.text = 'Bisnis Digital';
              Get.back();
            },
          ),
          ButtonOutline(
            text: 'Kewirausahaan',
            colorBorder: Colors.black87,
            fontColor: Colors.black87,
            onPressed: () {
              cProdi.text = 'Kewirausahaan';
              Get.back();
            },
          ),
          ButtonOutline(
            text: 'Menejemen Informatika',
            colorBorder: Colors.black87,
            fontColor: Colors.black87,
            onPressed: () {
              cProdi.text = 'Menejemen Informatika';
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    if (dataPemilih == null) {
      title = 'Tambah Pemilih';
      cNama.text = '';
      cStb.text = '';
      cJkl.text = '';
      cProdi.text = '';
    } else {
      title = 'Edit Pemilih';
      dataPemilih = Get.arguments;
      cNama.text = dataPemilih!.nama!;
      cStb.text = dataPemilih!.stb.toString();
    }
    super.onInit();
  }
}
