import 'package:admin_voting/app/core/interface/app_bar/app_bar_back.dart';
import 'package:admin_voting/app/core/models/waktu_pemilihan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                (e) => e.isAktif == false,
              )
              .toList();

          final dataAktif = listWaktuPemilihanAktif.first;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                if (listWaktuPemilihanAktif.isNotEmpty)
                  cardPeriodeBerlangsung(dataAktif)
                // InkWell(
                //   onTap: () {
                //     controller.selesaikanPemilihan(dataAktif.id!);
                //   },
                //   child: cardPeriodeBerlangsung(dataAktif),
                // )
                else
                  const Text(
                    'Tidak ada pemilihan yang sedang berlangsung',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                12.sH,
                const Divider(thickness: 2),
                20.sH,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pemilihan selesai :',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                4.sH,
                const Divider(thickness: 2),
                if (listWaktuPemilihanSelesai.isEmpty)
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
                      itemCount: listWaktuPemilihanSelesai.length,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        final WaktuPemModel dataPS =
                            listWaktuPemilihanSelesai[index];
                        final tsWM = dataPS.waktuMulai.toDate();
                        final tsWB = dataPS.waktuSelesai.toDate();

                        String formatWM =
                            DateFormat("HH : mm", "id_ID").format(tsWM);
                        String formatWB =
                            DateFormat("HH : mm", "id_ID").format(tsWB);
                        String tanggal =
                            DateFormat('dd MMMM yyyy', "id_ID").format(tsWB);
                        return ListTile(
                          title: Text(
                            '$formatWM s/d $formatWB',
                          ),
                          subtitle: Text(
                            tanggal,
                          ),
                          trailing: Text(
                            dataPS.isAktif ? 'Belum' : 'Selesai',
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
    final tsWM = dataAktif.waktuMulai.toDate();
    final tsWB = dataAktif.waktuSelesai.toDate();

    String formatWM = DateFormat("HH : mm", "id_ID").format(tsWM);
    String formatWB = DateFormat("HH : mm", "id_ID").format(tsWB);
    String tanggal = DateFormat('dd MMMM', "id_ID").format(tsWB);

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
              title: 'Waktu mulai',
              subTitle: formatWM,
            ),
            8.sH,
            contentPemBerlangsung(
              title: 'Waktu selesai',
              subTitle: formatWB,
            ),
            8.sH,
            contentPemBerlangsung(
              title: 'Tanggal',
              subTitle: tanggal,
            ),
            8.sH,
            contentPemBerlangsung(
              title: 'periode',
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
