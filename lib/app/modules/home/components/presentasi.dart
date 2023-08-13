import 'dart:developer';

import 'package:collection_ext/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/models/capres.dart';
import '../controllers/home_controller.dart';
import 'card_capres.dart';
import 'card_statistik.dart';
import 'indicator.dart';

class Presentasi extends GetView<HomeController> {
  const Presentasi({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) {
          // int totalPemilih = 20;
          final totalPemilih =
              controller.controllerPemilih.listPemilihModel.length;
          final dataSemuaPemilihan = state!;
          final capres01 = dataSemuaPemilihan
              .where((e) => e.capres!.id == 'h7vlv6B98ZcQCU7jE6Uw')
              .toList();
          final capres02 = dataSemuaPemilihan
              .where((e) => e.capres!.id == 'P3KfoNxdvtFqUwbR9urP')
              .toList();
          final capres03 = dataSemuaPemilihan
              .where((e) => e.capres!.id == 'pk3QADckQZfpBLZsSG3L')
              .toList();
          final pemilihCapres01 = (capres01.length / totalPemilih) * 100;
          final pemilihCapres02 = (capres02.length / totalPemilih) * 100;
          final pemilihCapres03 = (capres03.length / totalPemilih) * 100;
          final persenCapres01 = '${pemilihCapres01.toStringAsFixed(2)}%';
          final persenCapres02 = '${pemilihCapres02.toStringAsFixed(2)}%';
          final persenCapres03 = '${pemilihCapres03.toStringAsFixed(2)}%';
          final listPersen = [
            persenCapres01,
            persenCapres02,
            persenCapres03,
          ];
          return controller.controllerCapres.obx(
            (stateHome) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          ...List.generate(
                            stateHome!.length,
                            (index) => CardCapresPV(
                              data: stateHome[index],
                              colors: controller.listColors[index],
                              persen: listPersen[index],
                              onTap: () {
                                log('object Capres');
                              },
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  30.sH,
                  CardStatistik(
                    dataSemuaPemilihan: state,
                    dataSemuaCapres: stateHome,
                    listColor: controller.listColors,
                  ),
                  listIndokator(stateHome),
                ],
              ),
            ),
            onEmpty: const Center(child: Text("Masih Kosong")),
            onLoading: const LoadingState(),
            onError: (e) {
              return Center(child: Text("pesan error : $e"));
            },
          );
        },
        onEmpty: const Center(child: Text("Masih Kosong")),
        onLoading: const LoadingState(),
        onError: (e) {
          return Center(child: Text("pesan error : $e"));
        },
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
