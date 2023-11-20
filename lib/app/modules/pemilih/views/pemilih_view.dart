import 'package:admin_voting/app/core/colors/colors_app.dart';
import 'package:admin_voting/app/core/models/pemilih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../components/detail_pemilih.dart';
import '../components/form_search.dart';
import '../components/penghuni.dart';
import '../controllers/pemilih_controller.dart';

class PemilihView extends GetView<PemilihController> {
  const PemilihView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.white,
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: const FormSearch(),
      ),
      body: controller.obx(
        (state) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state!.length,
            itemBuilder: (
              context,
              index,
            ) {
              final PemilihModel dataPemilih = state[index];
              return Pemilih(
                listPemilih: state,
                index: index,
                onTap: () {
                  Get.to(DetailPemilih(
                    data: dataPemilih,
                  ));
                },
                onLongTap: () {
                  controller.alertPemilih(dataPemilih);
                },
                onTapDelete: () {
                  controller.alertDeletePemilih(dataPemilih);
                },
              );
            },
          );
        },
        onEmpty: const EmptyState(),
        onLoading: const LoadingState(),
        onError: (e) => ErrorState(error: e!),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Get.toNamed(Routes.FORM_PEMILIH);
      //   },
      //   label: Row(
      //     children: [
      //       const Icon(LineIcons.plus),
      //       8.sW,
      //       const Text('Pemilih'),
      //     ],
      //   ),
      // ),
    );
  }
}
