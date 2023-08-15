import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/models/pemilihan.dart';
import '../../capres/controllers/capres_controller.dart';
import '../../pemilih/controllers/pemilih_controller.dart';

class StatisticController extends GetxController
    with StateMixin<List<PemilihanModel>> {
  final touchedIndex = 0.obs;
  PageController? pageController;
  final selectionTab = 0.obs;

  void onPage(int v) {
    selectionTab.value = v;
  }

  List<PemilihanModel> listPemilihanModel = [];
  // List<PemilihanModel> listPemilihanModel = [];
  Stream<QuerySnapshot<Map<String, dynamic>>> get getListCapres =>
      ConstansApp.firestore
          .collection(ConstansApp.pemilihanCollection)
          .snapshots();

  final listColors = [
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.grey,
    Colors.black26,
    Colors.white54,
    Colors.orange,
    Colors.blueGrey,
    Colors.amber,
  ];

  final controllerCapres = Get.find<CapresController>();
  final controllerPemilih = Get.find<PemilihController>();

  @override
  void onInit() {
    pageController = PageController(initialPage: selectionTab.value);

    getListCapres.listen((event) {
      if (event.size != 0) {
        listPemilihanModel = List.generate(
          event.docs.length,
          (index) => PemilihanModel.fromDocumentSnapshot(event.docs[index]),
        ).toList();
        log('${listPemilihanModel.length}', name: 'Pemilihan');
        change(listPemilihanModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'Pemilihan');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
