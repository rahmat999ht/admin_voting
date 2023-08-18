import 'package:admin_voting/app/core/colors/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:packages/packages.dart';

import '../../../core/models/riwayat_pemilihan.dart';
import '../components/card_home.dart';
import '../components/header_home.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: ColorApp.white.withOpacity(0),
        title: const HeaderHome(),
      ),
      body: controller.obx(
        (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.sH,
              pemilihanTerakhir(),
              20.sH,
              cardAction(),
              20.sH,
              RiwayatPemilihan(state!)
            ],
          );
        },
        onEmpty: const EmptyState(),
        onLoading: const LoadingState(),
        onError: (e) => ErrorState(error: e!),
      ),
    );
  }

  Row pemilihanTerakhir() {
    return Row(
      children: [
        20.sW,
        const Text(
          'Pemilihan Terakhir : ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          'Pemilihan Terakhir',
          style: TextStyle(
            fontSize: 14,
            color: ColorApp.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Card cardAction() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: ColorApp.primary,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardHome(
              title: "Pemilihan",
              icon: LineIcons.plusCircle,
              onTap: controller.toFormAddPemilihan,
            ),
            CardHome(
              title: "Control",
              icon: LineIcons.boxOpen,
              onTap: controller.toControlPemilihan,
            ),
            CardHome(
              title: "Info",
              icon: LineIcons.infoCircle,
              onTap: controller.toInfoApp,
            ),
          ],
        ),
      ),
    );
  }
}

class RiwayatPemilihan extends GetView<HomeController> {
  const RiwayatPemilihan(
    this.listData, {
    super.key,
  });

  final List<RiwayatPemModel> listData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Riwayat Pemilihan : ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          if (listData.isEmpty)
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
                itemCount: listData.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  // final RiwayatPemModel data = listData[index];
                  return const ListTile(
                    title: Text(
                      'data',
                    ),
                    subtitle: Text(
                      'data',
                    ),
                    trailing: Text(
                      'data',
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
