import 'dart:developer';

import 'package:admin_voting/app/core/interface/alerts/alert_actions.dart';
import 'package:admin_voting/app/core/interface/alerts/alert_info.dart';
import 'package:admin_voting/app/core/models/riwayat_pemilihan.dart';
import 'package:admin_voting/app/modules/capres/controllers/capres_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/models/waktu_pemilihan.dart';
import '../../../core/services/method.dart';
import '../../pemilih/controllers/pemilih_controller.dart';

class ControlPemController extends GetxController
    with StateMixin<List<WaktuPemModel>> {
  final methodApp = MethodApp();

  List<WaktuPemModel> listWaktuPemilihanModel = <WaktuPemModel>[];
  List<WaktuPemModel> listWaktuPemilihanAktif = <WaktuPemModel>[];

  PemilihController? pemilihC;
  CapresController? capresC;

  Stream<QuerySnapshot<Map<String, dynamic>>> get getListWaktuPemilihan =>
      ConstansApp.firestore
          .collection(ConstansApp.waktuPemilihanCollection)
          .snapshots();

  @override
  void onInit() {
    pemilihC = Get.find<PemilihController>();
    capresC = Get.find<CapresController>();
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

  void selesaikanPemilihan({
    required String idWaktuPemilihan,
    required List<DataPemilihan> dataPemilihan,
  }) {
    alertActions(
      'into',
      'apa anda yakin menyelesaikan pemilihan yang sedang berjalan??',
      [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('tidak'),
        ),
        20.sW,
        TextButton(
          onPressed: () => selesai(
            idWaktuPemilihan: idWaktuPemilihan,
            dataPemilihan: dataPemilihan,
          ),
          child: const Text('ya'),
        ),
      ],
    );
  }

  void selesai({
    required String idWaktuPemilihan,
    required List<DataPemilihan> dataPemilihan,
  }) {
    change([], status: RxStatus.loading());
    // update tabel waktu pemilihan sesuai id pemilihan yang sedang berjalan
    // dan akan menonaktifkan status aktif dari waktu pemilihan
    methodApp.updateWaktuPemilihan(
      idWP: idWaktuPemilihan,
      data: {
        'isAktif': false,
      },
    );

    // update tabel pemilih
    // dan akan mengubah semua status memilih menjadi belum memilih
    final sudahMemilih = pemilihC!.listSudahMemilih;
    for (int i = 0; i < sudahMemilih.length; i++) {
      methodApp.updatePemilih(
        idPemilih: sudahMemilih[i].id!,
        data: {'isMemilih': false},
      );
    }

    // update tabel capres
    // dan akan mengubah semua status periado menjadi false
    // artinya sudah bukan capres periode ini
    // dan di CRUD capres sdh tidak di tampilkan
    final capres = capresC!.listCapresModelIsPeriode;
    for (int i = 0; i < capres.length; i++) {
      methodApp.updateCapres(
        idCapres: capres[i].id!,
        data: {'isPeriode': false},
      );
    }

    // add data di tabel riwayat pemilihan
    final docWaltuPem = methodApp.waktuPem(idWaktuPemilihan);
    final data = RiwayatPemModel(
      createAt: Timestamp.now(),
      periodeTahun: docWaltuPem,
      dataPemilihan: dataPemilihan,
    ).toMap();
    methodApp.addRiwayatPemilihan(
      data: data,
    );
    change(listWaktuPemilihanModel, status: RxStatus.success());
    Get.back();
    alertInfo(
      'info',
      'pemilihan pada periode ini telah di rekap',
    );
  }
}
