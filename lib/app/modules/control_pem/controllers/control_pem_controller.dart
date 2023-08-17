import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/models/waktu_pemilihan.dart';
import '../../../core/services/method.dart';

class ControlPemController extends GetxController
    with StateMixin<List<WaktuPemModel>> {
  final methodApp = MethodApp();

  List<WaktuPemModel> listWaktuPemilihanModel = <WaktuPemModel>[];
  List<WaktuPemModel> listWaktuPemilihanAktif = <WaktuPemModel>[];

  Stream<QuerySnapshot<Map<String, dynamic>>> get getListWaktuPemilihan =>
      ConstansApp.firestore
          .collection(ConstansApp.waktuPemilihanCollection)
          .snapshots();

  @override
  void onInit() {
    getListWaktuPemilihan.listen((event) {
      if (event.size != 0) {
        listWaktuPemilihanModel = List.generate(
          event.docs.length,
          (index) => WaktuPemModel.fromDocumentSnapshot(
            event.docs[index],
          ),
        ).toList();
        listWaktuPemilihanAktif = listWaktuPemilihanModel
            .where(
              (e) => e.isAktif == true,
            )
            .toList();

        log('${listWaktuPemilihanModel.length}', name: 'WaktuPemilihan');
        change(listWaktuPemilihanModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'WaktuPemilihan');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
