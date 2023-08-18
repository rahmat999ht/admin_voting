import 'dart:developer';

import 'package:admin_voting/app/core/models/riwayat_pemilihan.dart';
import 'package:admin_voting/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../core/constans/constans_app.dart';

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
}
