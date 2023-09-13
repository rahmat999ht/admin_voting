import 'dart:developer';

import 'package:admin_voting/app/core/colors/colors_app.dart';
import 'package:admin_voting/app/core/services/method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        actions: logOut,
      ),
      body: controller.obx(
        (state) {
          state!.sort(
            (a, b) => a.createAt.compareTo(b.createAt),
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.sH,
              pemilihanTerakhir(state.last),
              20.sH,
              cardAction(),
              20.sH,
              Expanded(
                child: RiwayatPemilihan(state),
              )
            ],
          );
        },
        onEmpty: Column(
          children: [
            20.sH,
            pemilihanTerakhir(null),
            20.sH,
            cardAction(),
            20.sH,
            const EmptyState(),
          ],
        ),
        onLoading: const LoadingState(),
        onError: (e) => ErrorState(error: e!),
      ),
    );
  }

  List<Widget> get logOut {
    return [
      GestureDetector(
        onTap: controller.alertLogOut,
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 26,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: ColorApp.primary),
          ),
          child: SizedBox(
            height: 40,
            width: 40,
            child: Center(
              child: Icon(
                Icons.logout,
                color: ColorApp.primary,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  Row pemilihanTerakhir(RiwayatPemModel? pemilihanTerakhir) {
    String tanggal = '';
    if (pemilihanTerakhir == null) {
      tanggal = '-';
    } else {
      final toDate = pemilihanTerakhir.createAt.toDate();
      tanggal = DateFormat('dd MMMM yyyy', "id_ID").format(toDate);
    }

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
          tanggal,
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
    listData.sort(
      (a, b) => b.createAt.compareTo(a.createAt),
    );
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
                  MethodApp methodApp = MethodApp();
                  final RiwayatPemModel data = listData[index];
                  // final createAtt = data.createAt.toDate();

                  // String jam = DateFormat("HH : mm", "id_ID").format(periode);
                  // String tanggal =
                  //     DateFormat('dd MMMM yyyy', "id_ID").format(createAtt);

                  int maxTotalPemilih = -1;
                  int maxIndex = -1;

                  for (int i = 0; i < data.dataPemilihan.length; i++) {
                    if (data.dataPemilihan[i].totalPemilih > maxTotalPemilih) {
                      maxTotalPemilih = data.dataPemilihan[i].totalPemilih;
                      maxIndex = i;
                    }
                  }
                  if (maxIndex != -1) {
                    final dataCapres = data.dataPemilihan[maxIndex];
                    log(maxIndex.toString(), name: 'maxIndex');
                    log(dataCapres.idCapres.id.toString(), name: 'capres');

                    return StreamBuilder(
                      stream:
                          methodApp.capres(dataCapres.idCapres.id).snapshots(),
                      builder: (ctx, s) {
                        if (s.hasData) {
                          log(s.data!.toString(), name: 'capres');
                          final dataCapresTerpilih = s.data!.data()!;
                          return StreamBuilder(
                            stream: methodApp
                                .waktuPem(data.periodeTahun.id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final dataWaktuPem = snapshot.data!.data();
                                log('data dataWaktuPem : $dataWaktuPem');
                                log('data idWaktuPem : ${data.periodeTahun.id}');
                                return ListTile(
                                  onTap: () {
                                    // Get.to(page)
                                  },
                                  title: Text(
                                    dataCapresTerpilih.nama!,
                                  ),
                                  subtitle: const Text(
                                    'Bem terpilih',
                                  ),
                                  leading: ClipOval(
                                    child: dataCapresTerpilih.foto == null
                                        ? const SizedBox(height: 30)
                                        : Image.network(
                                            dataCapresTerpilih.foto!,
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  trailing: Text(dataWaktuPem!.periode),
                                );
                              } else {
                                return const LoadingState();
                              }
                            },
                          );
                        } else if (s.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingState();
                        } else {
                          return const EmptyState();
                        }
                      },
                    );
                  } else {
                    return const EmptyState();
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
