import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_actions.dart';
import '../../../core/models/capres.dart';
import '../../../core/services/method.dart';

class CapresController extends GetxController
    with StateMixin<List<CapresModel>> {
  final methodApp = MethodApp();
  final touchedIndex = 0.obs;
  int lengthCapres = 0;

  List<CapresModel> listCapresModel = [];

  final cSearch = TextEditingController();
  final isSearch = false.obs;

  void onChange(String value) {
    value.isEmpty ? isSearch.value = false : isSearch.value = true;
    change(
      value.isEmpty
          ? listCapresModel
          : listCapresModel
              .where((element) => element.stb.toString().toLowerCase().contains(
                    value.toLowerCase(),
                  ))
              .toList(),
      status: RxStatus.success(),
    );
  }

  Future alertDeleteCapres(CapresModel data) async {
    return await alertActions(
      'Peringatan',
      'Apa anda yakin ingin menghapus Capres : ${data.nama}',
      [
        ButtonPrymary(
          text: 'Ya',
          onPressed: () {
            deleteCapres(data.id!);
            Get.snackbar(
              'Info',
              'Berhasil Menghapus ${data.nama} sebagai Capres',
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

  void deleteCapres(String id) {
    methodApp.deleteCapres(
      idCapres: id,
    );
    Get.back();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get getListCapres =>
      ConstansApp.firestore
          .collection(ConstansApp.capresCollection)
          .snapshots();

  @override
  void onInit() {
    getListCapres.listen((event) {
      if (event.size != 0) {
        listCapresModel = List.generate(
          event.docs.length,
          (index) => CapresModel.fromDocumentSnapshot(event.docs[index]),
        ).toList();
        listCapresModel.sort(
          (a, b) => a.noUrut!.compareTo(b.noUrut!),
        );
        lengthCapres = listCapresModel.length;
        log('${listCapresModel.length}', name: 'Capres');
        change(listCapresModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'Capres');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
