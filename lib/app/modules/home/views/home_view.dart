import 'package:admin_voting/app/core/colors/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:packages/packages.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.sH,
          pemilihanTerakhir(),
          20.sH,
          cardAction(),
          20.sH,
          const RiwayatPemilihan()
        ],
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
              onTap: () {},
            ),
            CardHome(
              title: "Control",
              icon: LineIcons.boxOpen,
              onTap: () {},
            ),
            CardHome(
              title: "Info",
              icon: LineIcons.infoCircle,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class RiwayatPemilihan extends StatelessWidget {
  const RiwayatPemilihan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Pemilihan : ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
