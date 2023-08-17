import 'package:admin_voting/app/core/interface/app_bar/app_bar_back.dart';
import 'package:admin_voting/app/core/models/waktu_pemilihan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../controllers/control_pem_controller.dart';

class ControlPemView extends GetView<ControlPemController> {
  const ControlPemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBack(title: 'Control Pemilihan'),
      body: controller.obx(
        (state) {
          final listWaktuPemilihanAktif = state!
              .where(
                (e) => e.isAktif == true,
              )
              .toList();

          final listWaktuPemilihanSelesai = state
              .where(
                (e) => e.isAktif == true,
              )
              .toList();

          final dataAktif = listWaktuPemilihanAktif.first;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.sH,
                const Text(
                  'Pemilihan Berlangsung :',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                4.sH,
                const Divider(thickness: 2),
                12.sH,
                cardPeriodeBerlangsung(dataAktif),
                12.sH,
                const Divider(thickness: 2),
                20.sH,
                const Text(
                  'Pemilihan selesai :',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                4.sH,
                const Divider(thickness: 2),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listWaktuPemilihanSelesai.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final WaktuPemModel dataPemilihan =
                          listWaktuPemilihanSelesai[index];
                      return ListTile(
                        title: Text(
                          dataPemilihan.periode,
                        ),
                        subtitle: Text(
                          dataPemilihan.periode,
                        ),
                        trailing: Text(
                          dataPemilihan.periode,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        onEmpty: const EmptyState(),
        onLoading: const LoadingState(),
        onError: (e) => ErrorState(error: e!),
      ),
    );
  }

  Card cardPeriodeBerlangsung(WaktuPemModel dataAktif) {
    // final tglMulai = DateTime.parse(dataAktif.waktuMulai)
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: ColorApp.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            contentPemBerlangsung(
              title: 'periode',
              subTitle: dataAktif.periode,
            ),
            8.sH,
            contentPemBerlangsung(
              title: 'Waktu mulai',
              subTitle: dataAktif.periode,
            ),
            8.sH,
            contentPemBerlangsung(
              title: 'Waktu selesai',
              subTitle: dataAktif.periode,
            ),
          ],
        ),
      ),
    );
  }

  Row contentPemBerlangsung({
    required String title,
    required String subTitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title : ',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
