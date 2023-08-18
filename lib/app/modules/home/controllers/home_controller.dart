import 'dart:developer';

import 'package:admin_voting/app/core/colors/colors_app.dart';
import 'package:admin_voting/app/core/models/riwayat_pemilihan.dart';
import 'package:admin_voting/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_content.dart';

class HomeController extends GetxController
    with StateMixin<List<RiwayatPemModel>> {
  void toFormAddPemilihan() {
    Get.toNamed(Routes.FORM_ADD_PEM);
  }

  void toControlPemilihan() {
    Get.toNamed(Routes.CONTROL_PEM);
  }

  void toInfoApp() {
    Get.toNamed(Routes.INFO_APP);
  }

  List<RiwayatPemModel> listRiwayatPemilihanModel = <RiwayatPemModel>[];

  Stream<QuerySnapshot<Map<String, dynamic>>> get getListRiwayatPemilihan =>
      ConstansApp.firestore
          .collection(ConstansApp.riwayatPemilihanCollection)
          .snapshots();

  @override
  void onInit() {
    getListRiwayatPemilihan.listen((event) {
      if (event.size != 0) {
        listRiwayatPemilihanModel = List.generate(
          event.docs.length,
          (index) => RiwayatPemModel.fromDocumentSnapshot(
            event.docs[index],
          ),
        ).toList();

        log('${listRiwayatPemilihanModel.length}', name: 'RiwayatPemilihan');
        change(listRiwayatPemilihanModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'RiwayatPemilihan');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }

  Future alertLogOut() async {
    return await alertContent(
      title: 'Peringatan',
      content: Column(
        children: [
          const Text('Apa anda yakin ingin log-out ??'),
          30.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonText(
                'Batal',
                fontSize: 16,
                titleColor: ColorApp.primary,
                onTap: () {
                  Get.back();
                },
              ),
              30.sW,
              ButtonText(
                'Ya',
                fontSize: 16,
                titleColor: ColorApp.red,
                onTap: () async {
                  await logOut();
                },
              ),
              30.sW,
            ],
          ),
        ],
      ),
    );
  }

  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("idLogin", '');
    Get.offAllNamed(
      Routes.LOGIN,
    );
  }
}
