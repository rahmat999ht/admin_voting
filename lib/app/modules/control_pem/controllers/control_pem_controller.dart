import 'dart:developer';

import 'package:admin_voting/app/core/models/riwayat_pemilihan.dart';
import 'package:admin_voting/app/modules/capres/controllers/capres_controller.dart';
import 'package:admin_voting/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:admin_voting/app/modules/pemilih/controllers/pemilih_controller.dart';
import 'package:admin_voting/app/modules/statistic/controllers/statistic_controller.dart';
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

  final staticticC = Get.find<StatisticController>();
  final capresC = Get.find<CapresController>();
  final dashC = Get.find<DashboardController>();
  final pemilihC = Get.find<PemilihController>();

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

  void selesaikanPemilihan({
    required String idWaktuPemilihan,
    required List<DataPemilihan> dataPemilihan,
  }) {
    // update tabel waktu pemilihan
    methodApp.updateWaktuPemilihan(
      idWP: idWaktuPemilihan,
      data: {
        'isAktif': false,
      },
    );
    final sudahMemilih = pemilihC.listSudahMemilih;

    for (int i = 0; i < sudahMemilih.length; i++) {
      methodApp.updatePemilih(
        idPemilih: sudahMemilih[i].id!,
        data: {'isMemilih': false},
      );
    }

    final capres = capresC.listCapresModelIsPeriode;

    for (int i = 0; i < capres.length; i++) {
      methodApp.updateCapres(
        idCapres: capres[i].id!,
        data: {'isPeriode': false},
      );
    }

    // add data di tabel riwayat pemilihan
    final data = RiwayatPemModel(
      periodeTahun: Timestamp.now(),
      dataPemilihan: dataPemilihan,
    ).toMap();
    methodApp.addRiwayatPemilihan(
      data: data,
    );
    change(listWaktuPemilihanModel, status: RxStatus.success());
  }
}
