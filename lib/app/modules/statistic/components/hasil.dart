import 'dart:developer';

import 'package:admin_voting/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../../../core/models/pemilih_capres.dart';
import '../../pemilih/controllers/pemilih_controller.dart';
import '../controllers/statistic_controller.dart';

class Hasil extends GetView<StatisticController> {
  const Hasil({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.controllerControl.obx(
        (stCP) {
          final stateAktif = stCP!.where((e) => e.isAktif == true).toList();
          if (stateAktif.isEmpty) {
            return const HasilAkhir();
          } else {
            return const ProsesPemilihan();
          }
        },
        onEmpty: const EmptyState(),
        onLoading: const LoadingState(),
        onError: (e) => ErrorState(error: e.toString()),
      ),
    );
  }
}

class HasilAkhir extends GetView<StatisticController> {
  const HasilAkhir({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return controller.controllerCapres.obx(
          (stateCapres) {
            // variabel patokan total pemilih aktif
            final totalPemilih =
                controller.controllerPemilih.listPemilihAktif.length;
            final listPemilihCapres = <CapresTerpilihModel>[];
            for (int index = 0; index < stateCapres!.length; index++) {
              final dataPemilihanCapres = state!
                  .where((e) => e.capres!.id == stateCapres[index].id)
                  .toList();
              final persen = (dataPemilihanCapres.length / totalPemilih) * 100;
              final stringPersen = '${persen.toStringAsFixed(2)}%';
              log('dataPemilihanCapres $dataPemilihanCapres');
              log('listPemilihCapres $listPemilihCapres');
              // variabel patokan total suara kandidat
              final totalSuaraCapres = dataPemilihanCapres.length;
              // variabel patokan total nilai penggali
              // yang di dapatkan berdarakan rumus nilai penggali
              final nilaiPengaliCapres =
                  (totalPemilih + 1) / (totalSuaraCapres + 1);
              // variabel patokan total nilai validasi
              // yang di dapatkan berdarakan rumus nilai validasi
              final nilaiValidasiCapres =
                  (totalSuaraCapres * nilaiPengaliCapres) / (totalPemilih);
              listPemilihCapres.add(
                CapresTerpilihModel(
                  capres: stateCapres[index],
                  jumlahSuara: totalSuaraCapres.toDouble(),
                  nilaiPengali: nilaiPengaliCapres.toDouble(),
                  nilaiValidasi: nilaiValidasiCapres.toDouble(),
                  persen: stringPersen,
                ),
              );
            }
            listPemilihCapres.sort(
              (a, b) => b.jumlahSuara.compareTo(a.jumlahSuara),
            );
            final data = listPemilihCapres.first;
            final dataCapres = listPemilihCapres.first.capres;
            //nilai validasi dijadikan dua angka di belakang koma
            final nilaiValidasi =
                double.parse(data.nilaiValidasi.toStringAsFixed(2));

            return Center(
              child: InkWell(
                onTap: () {
                  log("object");
                  log('listPemilihCapres ${data.nilaiValidasi}');
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  //height: 130,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      12.sH,
                      const Text(
                        "Selamat kepada yang terpilih",
                        style: TextStyle(fontSize: 24),
                      ),
                      12.sH,
                      Text(
                        "${dataCapres.noUrut}, ${dataCapres.nama}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      12.sH,
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300),
                          side: BorderSide(
                            color: ColorApp.primary,
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "${dataCapres.foto}",
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                      12.sH,
                      Text(
                        "Dengan nilai Pengali : ${data.nilaiPengali}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      12.sH,
                      Text(
                        "Dengan nilai Validasi : $nilaiValidasi",
                        style: const TextStyle(fontSize: 18),
                      ),
                      12.sH,
                    ],
                  ),
                ),
              ),
            );
          },
          onEmpty: const EmptyState(),
          onLoading: const LoadingState(),
          onError: (e) => ErrorState(error: e.toString()),
        );
      },
      onEmpty: const EmptyState(),
      onLoading: const LoadingState(),
      onError: (e) => ErrorState(error: e.toString()),
    );
  }
}

class ProsesPemilihan extends GetView<HomeController> {
  const ProsesPemilihan({super.key});

  @override
  Widget build(BuildContext context) {
    final PemilihController pemilihC = Get.find<PemilihController>();
    return pemilihC.obx(
      (state) {
        final int sudahMemilih = pemilihC.listSudahMemilih.length;
        final int semuaPemilih = state!.length;
        final double prosesPemilihan = (sudahMemilih / semuaPemilih) * 100;
        log(prosesPemilihan.toString());
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pemilihan masih berlangsung',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              40.sH,
              _AnimatedLiquidCircularProgressIndicator(
                value: prosesPemilihan,
              ),
            ],
          ),
        );
      },
      onEmpty: const EmptyState(),
      onLoading: const LoadingState(),
      onError: (e) => ErrorState(error: e!),
    );
  }
}

class _AnimatedLiquidCircularProgressIndicator extends StatefulWidget {
  const _AnimatedLiquidCircularProgressIndicator({required this.value});
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCircularProgressIndicatorState();

  final double value;
}

class _AnimatedLiquidCircularProgressIndicatorState
    extends State<_AnimatedLiquidCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
    // log(widget.value.toString());
    // log(_animationController.value.toString());
    // if (percentage! < widget.value) {

    //   log(_animationController.value.toString());
    // }
    // if (percentage == widget.value) {
    //   _animationController.dispose();
    //   log(_animationController.value.toString());
    // }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        height: 300.0,
        child: LiquidCircularProgressIndicator(
          value: _animationController.value,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
          borderColor: Colors.grey,
          borderWidth: 5.0,
          center: Text(
            "${widget.value.toStringAsFixed(0)}%",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
