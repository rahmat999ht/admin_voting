import 'dart:developer';

import 'package:admin_voting/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:packages/extensions/size_app.dart';
import 'package:packages/state/loading.dart';

import '../../pemilih/controllers/pemilih_controller.dart';
import '../controllers/statistic_controller.dart';

class Hasil extends GetView<StatisticController> {
  const Hasil({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HasilSementara(),
    );
  }
}

class HasilAkhir extends GetView<HomeController> {
  const HasilAkhir({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            log("object");
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
                const Text(
                  "No 1, Nama",
                  style: TextStyle(fontSize: 20),
                ),
                12.sH,
                ClipOval(
                  child: Container(
                    height: 160,
                    width: 160,
                    color: Colors.grey[200],
                    child: Image.network(
                      "https://ui-avatars.com/api/?name=John+Doe",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                12.sH,
                const Text(
                  "Dengan total suara 90% ",
                  style: TextStyle(fontSize: 20),
                ),
                12.sH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HasilSementara extends GetView<HomeController> {
  const HasilSementara({super.key});

  @override
  Widget build(BuildContext context) {
    final PemilihController pemilihC = Get.find<PemilihController>();
    return pemilihC.obx(
      (state) {
        final int sudahMemilih = pemilihC.listSudahMemilih.length;
        final int semuaPemilih = state!.length;
        final double hasilSementara = (sudahMemilih / semuaPemilih) * 100;
        log(hasilSementara.toString());
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hasil Sementara',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              40.sH,
              _AnimatedLiquidCircularProgressIndicator(
                value: hasilSementara,
              ),
            ],
          ),
        );
      },
      onEmpty: const Center(child: Text("Masih Kosong")),
      onLoading: const LoadingState(),
      onError: (e) {
        return Center(child: Text("pesan error : $e"));
      },
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
