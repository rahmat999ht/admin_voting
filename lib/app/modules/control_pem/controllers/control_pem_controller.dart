import 'dart:developer';

import 'package:admin_voting/app/core/models/riwayat_pemilihan.dart';
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

  void selesaikanPemilihan(
    String id,
  ) {
    // update tabel waktu pemilihan
    methodApp.updateWaktuPemilihan(
      idWP: id,
      data: {
        'isAktif': false,
      },
    );

    // add data di tabel riwayat pemilihan
    final docCapres1 = methodApp.capres('P3KfoNxdvtFqUwbR9urP');
    final docCapres2 = methodApp.capres('h7vlv6B98ZcQCU7jE6Uw');
    final docCapres3 = methodApp.capres('pk3QADckQZfpBLZsSG3L');
    final data = RiwayatPemModel(
      periodeTahun: Timestamp.now(),
      dataPemilihan: [
        DataPemilihan(
          idCapres: docCapres1,
          totalPemilih: 20,
        ),
        DataPemilihan(
          idCapres: docCapres2,
          totalPemilih: 27,
        ),
        DataPemilihan(
          idCapres: docCapres3,
          totalPemilih: 37,
        ),
      ],
    ).toMap();
    methodApp.addRiwayatPemilihan(
      data: data,
    );
  }
}
