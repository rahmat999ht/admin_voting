import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/models/pemilih.dart';

class PemilihController extends GetxController
    with StateMixin<List<PemilihModel>> {
  final touchedIndex = 0.obs;
  List<PemilihModel> listPemilihModel = [];
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
          (index) => PemilihModel.fromDocumentSnapshot(event.docs[index]),
        ).toList();
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
