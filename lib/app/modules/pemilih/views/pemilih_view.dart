import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../components/form_search.dart';
import '../components/penghuni.dart';
import '../controllers/pemilih_controller.dart';

class PemilihView extends GetView<PemilihController> {
  const PemilihView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              return Pemilih(
                listPemilih: state,
                index: index,
                onTap: () {},
              );
            },
          );
        },
        onEmpty: const Center(child: Text("Masih Kosong")),
        onLoading: const LoadingState(),
        onError: (e) {
          return Center(child: Text("error : $e"));
        },
      ),
    );
  }
}
