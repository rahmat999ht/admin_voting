import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/models/capres.dart';
import '../../../core/models/pemilih_capres.dart';
import '../../../core/models/pemilihan.dart';
import '../../pemilih/controllers/pemilih_controller.dart';

class CardStatistik extends GetView<PemilihController> {
  const CardStatistik({
    super.key,
    required this.dataSemuaPemilihan,
    required this.dataSemuaCapres,
    required this.listColor,
  });

  final List<PemilihanModel> dataSemuaPemilihan;
  final List<CapresModel> dataSemuaCapres;
  final List<Color> listColor;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        final listPemilihAktif =
            state!.where((e) => e.isAktif == true).toList();
        return SizedBox(
          width: Get.width,
          height: 250,
          child: Center(
            child: Obx(
              () => PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        controller.touchedIndex.value = -1;
                        return;
                      }
                      controller.touchedIndex.value =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  startDegreeOffset: -25,
                  centerSpaceRadius: 50,
                  sections: showingSections(listPemilihAktif.length),
                ),
              ),
            ),
          ),
        );
      },
      onEmpty: const EmptyState(),
      onLoading: const LoadingState(),
      onError: (e) => ErrorState(error: e!),
    );
  }

  List<PieChartSectionData> showingSections(int totalPemilih) {
    return List.generate(dataSemuaCapres.length + 1, (i) {
      final isTouched = i == controller.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 80.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final listPemilihCapres = <PemilihCapresModel>[];
      for (int index = 0; index < dataSemuaCapres.length; index++) {
        final dataPemilihanCapres = dataSemuaPemilihan
            .where((e) => e.capres!.id == dataSemuaCapres[index].id)
            .toList();
        final persen = (dataPemilihanCapres.length / totalPemilih) * 100;
        final stringPersen = '${persen.toStringAsFixed(2)}%';
        log('dataPemilihanCapres $dataPemilihanCapres');
        log('listPemilihCapres $listPemilihCapres');
        listPemilihCapres.add(
          PemilihCapresModel(
            noUrut: dataSemuaCapres[index].noUrut!,
            bykPemilih: dataPemilihanCapres.length.toDouble(),
            persen: stringPersen,
          ),
        );
      }
      listPemilihCapres.sort(
        (a, b) => a.noUrut.compareTo(b.noUrut),
      );
      final belumMemilih =
          (controller.listBelumMemilih.length / totalPemilih) * 100;
      final persenanBelumMemilih = '${belumMemilih.toStringAsFixed(2)}%';

      listPemilihCapres.add(
        PemilihCapresModel(
          noUrut: 'belum dipilih kodong',
          bykPemilih: belumMemilih,
          persen: persenanBelumMemilih,
        ),
      );
      return PieChartSectionData(
        color: listColor[i],
        value: listPemilihCapres[i].bykPemilih,
        title: listPemilihCapres[i].persen,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
        ),
      );
    });
  }
}
