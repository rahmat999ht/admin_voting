import 'dart:developer';

import 'package:admin_voting/app/core/interface/app_bar/app_bar_back.dart';
import 'package:admin_voting/app/core/models/waktu_pemilihan.dart';
import 'package:admin_voting/app/modules/pemilih/controllers/pemilih_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../../../core/models/pemilihan.dart';
import '../../../core/models/riwayat_pemilihan.dart';
import '../../capres/controllers/capres_controller.dart';
import '../../statistic/controllers/statistic_controller.dart';
import '../controllers/control_pem_controller.dart';

class ControlPemView extends GetView<ControlPemController> {
  const ControlPemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StatisticController());
    Get.lazyPut(() => CapresController());
    Get.lazyPut(() => PemilihController());
    final staticticC = Get.find<StatisticController>();
    final capresC = Get.find<CapresController>();
    return Scaffold(
      appBar: appBarBack(title: 'Control Pemilihan'),
      body: controller.obx(
        (statePem) {
          log('statePem = ${statePem?.length ?? 0}');
          return staticticC.obx(
            (stateStatic) {
              log('stateStatic = ${stateStatic?.length ?? 0}');
              return capresC.obx(
                (stateCapres) {
                  log('stateCapres = ${stateCapres?.length ?? 0}');
                  final dataPemilihan = <DataPemilihan>[];
                  for (int index = 0; index < stateCapres!.length; index++) {
                    log('index = $index');
                    List<PemilihanModel>? dataPemilihanCapres = stateStatic!
                        .where((e) => e.capres!.id == stateCapres[index].id)
                        .toList();
                    final totalSuaraCapres = dataPemilihanCapres.length;
                    // log('dataPemilihanCapres $dataPemilihanCapres');
                    log('totalSuaraCapres $totalSuaraCapres');
                    final docCapres =
                        controller.methodApp.capres(stateCapres[index].id!);
                    dataPemilihan.add(
                      DataPemilihan(
                        idCapres: docCapres,
                        totalPemilih: totalSuaraCapres,
                      ),
                    );
                  }
                  log('dataPemilihan $dataPemilihan');

                  final listWaktuPemilihanAktif = statePem!
                      .where(
                        (e) => e.isAktif == true,
                      )
                      .toList();

                  final listWaktuPemilihanSelesai = statePem
                      .where(
                        (e) => e.isAktif == false,
                      )
                      .toList();
                  log('listWaktuPemilihanAktif = ${listWaktuPemilihanAktif.length}');
                  log('listWaktuPemilihanSelesai = ${listWaktuPemilihanSelesai.length}');

                  // final dataAktif = listWaktuPemilihanAktif.first;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.sH,
                        Row(
                          children: [
                            const Text(
                              'Pemilihan Berlangsung :',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            if (listWaktuPemilihanAktif.isNotEmpty)
                              ButtonOutline(
                                width: Get.width * 0.3,
                                text: 'Selesaikan',
                                fontSize: 16,
                                onPressed: () {
                                  controller.selesaikanPemilihan(
                                    idWaktuPemilihan:
                                        listWaktuPemilihanAktif.first.id!,
                                    dataPemilihan: dataPemilihan,
                                  );
                                },
                              ),
                          ],
                        ),
                        // 4.sH,
                        const Divider(thickness: 2),
                        12.sH,
                        if (listWaktuPemilihanAktif.isNotEmpty)
                          cardPeriodeBerlangsung(listWaktuPemilihanAktif.first)
                        else
                          const Text(
                            'Tidak ada pemilihan yang sedang berlangsung',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        12.sH,
                        const Divider(thickness: 2),
                        20.sH,
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pemilihan selesai :',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        4.sH,
                        const Divider(thickness: 2),
                        if (listWaktuPemilihanSelesai.isEmpty)
                          const Text(
                            'List masih kosong',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        else
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: listWaktuPemilihanSelesai.length,
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                final WaktuPemModel dataPS =
                                    listWaktuPemilihanSelesai[index];
                                final tsWM = dataPS.waktuMulai.toDate();
                                final tsWB = dataPS.waktuSelesai.toDate();

                                String formatWM =
                                    DateFormat("HH : mm", "id_ID").format(tsWM);
                                String formatWB =
                                    DateFormat("HH : mm", "id_ID").format(tsWB);
                                String tanggal =
                                    DateFormat('dd MMMM yyyy', "id_ID")
                                        .format(tsWB);
                                return ListTile(
                                  title: Text(
                                    '$formatWM s/d $formatWB',
                                  ),
                                  subtitle: Text(
                                    tanggal,
                                  ),
                                  trailing: Text(
                                    dataPS.isAktif ? 'Belum' : 'Selesai',
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
                onEmpty: const EmptyState(),
                onLoading: const LoadingState(),
                onError: (e) => ErrorState(error: e!),
              );
            },
            onEmpty: const EmptyState(),
            onLoading: const LoadingState(),
            onError: (e) => ErrorState(error: e!),
          );
        },
        onEmpty: const EmptyState(),
        onLoading: const LoadingState(),
        onError: (e) => ErrorState(error: e!),
      ),
    );
  }

  Card cardPeriodeBerlangsung(WaktuPemModel dataAktif) {
    final tsWM = dataAktif.waktuMulai.toDate();
    final tsWB = dataAktif.waktuSelesai.toDate();

    String formatWM = DateFormat("HH : mm", "id_ID").format(tsWM);
    String formatWB = DateFormat("HH : mm", "id_ID").format(tsWB);
    String tanggal = DateFormat('dd MMMM', "id_ID").format(tsWB);

    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: ColorApp.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            contentPemBerlangsung(
              title: 'Waktu mulai',
              subTitle: formatWM,
            ),
            8.sH,
            contentPemBerlangsung(
              title: 'Waktu selesai',
              subTitle: formatWB,
            ),
            8.sH,
            contentPemBerlangsung(
              title: 'Tanggal',
              subTitle: tanggal,
            ),
            8.sH,
            contentPemBerlangsung(
              title: 'periode',
              subTitle: dataAktif.periode,
            ),
          ],
        ),
      ),
    );
  }

  Row contentPemBerlangsung({
    required String title,
    required String subTitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title : ',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
