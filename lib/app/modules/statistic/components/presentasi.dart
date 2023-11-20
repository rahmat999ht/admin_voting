import 'dart:developer';

import 'package:admin_voting/app/modules/statistic/components/detail_capres.dart';
import 'package:admin_voting/app/modules/statistic/controllers/statistic_controller.dart';
import 'package:collection_ext/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/models/capres.dart';
import '../../../core/models/pemilih_capres.dart';
import 'card_capres.dart';
import 'card_statistik.dart';
import 'indicator.dart';

class Presentasi extends GetView<StatisticController> {
  const Presentasi({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) {
          // int totalPemilih = 20;
          return controller.controllerCapres.obx(
            (stateCapres) {
              final stateHome =
                  stateCapres!.where((e) => e.isPeriode == true).toList();
              final totalPemilih =
                  controller.controllerPemilih.listPemilihAktif.length;
              final listPemilihCapres = <PemilihCapresModel>[];
              for (int index = 0; index < stateHome.length; index++) {
                final dataPemilihanCapres = state!
                    .where((e) => e.capres!.id == stateHome[index].id)
                    .toList();
                final persen =
                    (dataPemilihanCapres.length / totalPemilih) * 100;
                final stringPersen = '${persen.toStringAsFixed(2)}%';
                log('dataPemilihanCapres $dataPemilihanCapres');
                log('listPemilihCapres $listPemilihCapres');
                listPemilihCapres.add(
                  PemilihCapresModel(
                    noUrut: stateHome[index].noUrut!,
                    bykPemilih: dataPemilihanCapres.length.toDouble(),
                    persen: stringPersen,
                  ),
                );
              }
              listPemilihCapres.sort(
                (a, b) => a.noUrut.compareTo(b.noUrut),
              );
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              stateHome.length,
                              (index) => CardCapresPV(
                                data: stateHome[index],
                                colors: controller.listColors[index],
                                persen: listPemilihCapres[index].persen,
                                onTap: () {
                                  Get.to(
                                    DetailCapres(data: stateHome[index]),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    30.sH,
                    CardStatistik(
                      dataSemuaPemilihan: state!,
                      dataSemuaCapres: stateHome,
                      listColor: controller.listColors,
                    ),
                    listIndokator(stateHome),
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
      ),
    );
  }

  Column listIndokator(List<CapresModel> stateHome) {
    return Column(
      children: [
        ...stateHome.mapIndexed((i, e) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20,
            ),
            child: Indicator(
              color: controller.listColors[i],
              text: e.nama!,
              isSquare: true,
            ),
          );
        }).toList(),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20,
          ),
          child: Indicator(
            color: controller.listColors[stateHome.length],
            text: 'Belum Memilih',
            isSquare: true,
          ),
        ),
      ],
    );
  }
}
