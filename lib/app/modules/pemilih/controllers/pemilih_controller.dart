import 'dart:developer';

import 'package:admin_voting/app/core/services/method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_actions.dart';
import '../../../core/models/pemilih.dart';

class PemilihController extends GetxController
    with StateMixin<List<PemilihModel>> {
  final methodApp = MethodApp();
  final touchedIndex = 0.obs;
  List<PemilihModel> listPemilihModel = [];
  List<PemilihModel> listPemilihAktif = [];
  List<PemilihModel> listBelumMemilih = [];
  List<PemilihModel> listSudahMemilih = [];

  final cSearch = TextEditingController();
  final isSearch = false.obs;

  void onChange(String value) {
    value.isEmpty ? isSearch.value = false : isSearch.value = true;
    change(
      value.isEmpty
          ? listPemilihModel
          : listPemilihModel
              .where((element) => element.stb.toString().toLowerCase().contains(
                    value.toLowerCase(),
                  ))
              .toList(),
      status: RxStatus.success(),
    );
  }

  Future alertDeletePemilih(PemilihModel data) async {
    return await alertActions(
      'Peringatan',
      'Apa anda yakin ingin menghapus pemilih : ${data.nama}',
      [
        ButtonPrymary(
          text: 'Ya',
          onPressed: () {
            deletePemilih(data.id!);
            Get.snackbar(
              'Info',
              'Berhasil Menghapus ${data.nama} sebagai pemilih',
            );
          },
        ),
        ButtonPrymary(
          text: 'Tidak',
          onPressed: Get.back,
        ),
      ],
    );
  }

  void deletePemilih(String id) {
    methodApp.deletePemilih(
      idPemilih: id,
    );
    Get.back();
  }

  Future alertPemilih(PemilihModel data) async {
    if (data.isAktif == false) {
      return await alertActions(
        'Status Pemilih',
        'Aktifkan Pemilih : ${data.nama}',
        [
          ButtonPrymary(
            text: 'Ya',
            onPressed: () {
              aktikanPemilih(data.id!);
            },
          ),
          ButtonPrymary(
            text: 'Tidak',
            onPressed: Get.back,
          ),
        ],
      );
    } else {
      return await alertActions(
        'Status Pemilih',
        'Non-Aktifkan Pemilih : ${data.nama}',
        [
          ButtonPrymary(
            text: 'Ya',
            onPressed: () {
              noAktikanPemilih(data.id!);
            },
          ),
          ButtonPrymary(
            text: 'Tidak',
            onPressed: Get.back,
          ),
        ],
      );
    }
  }

  void noAktikanPemilih(String id) {
    final data = {'isAktif': false};
    methodApp.updatePemilih(
      idPemilih: id,
      data: data,
    );
    Get.back();
  }

  void aktikanPemilih(String id) {
    final data = {'isAktif': true};
    methodApp.updatePemilih(
      idPemilih: id,
      data: data,
    );
    Get.back();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get getListPemilih =>
      ConstansApp.firestore
          .collection(ConstansApp.pemilihCollection)
          .snapshots();

  @override
  void onInit() {
    getListPemilih.listen((event) {
      if (event.size != 0) {
        listPemilihModel = List.generate(
          event.docs.length,
          (index) => PemilihModel.fromDocumentSnapshot(
            event.docs[index],
          ),
        ).toList();
        listPemilihAktif = listPemilihModel
            .where(
              (e) => e.isAktif == true,
            )
            .toList();
        listBelumMemilih = listPemilihModel
            .where((e) => e.isMemilih == false && e.isAktif == true)
            .toList();
        listSudahMemilih = listPemilihModel
            .where((e) => e.isMemilih == true && e.isAktif == true)
            .toList();

        log('${listPemilihModel.length}', name: 'Pemilih');
        change(listPemilihModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'Pemilih');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
