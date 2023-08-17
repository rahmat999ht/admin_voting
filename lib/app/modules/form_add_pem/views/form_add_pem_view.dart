import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../../../core/interface/app_bar/app_bar_back.dart';
import '../controllers/form_add_pem_controller.dart';

class FormAddPemView extends GetView<FormAddPemController> {
  const FormAddPemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBack(
        title: 'Tambah periode pemilihan',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    LineIcons.userEdit,
                    color: ColorApp.primary,
                    size: 100,
                  ),
                ),
                20.sH,
                Text(
                  'periode : ${controller.date.year}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                4.sH,
                const Divider(thickness: 2),
                20.sH,
                const Text(
                  'Set waktu pemilihan : ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                4.sH,
                const Divider(thickness: 2),
                12.sH,
                Row(
                  children: [
                    Expanded(
                      child: TextForm.border(
                        controller: controller.jamMulaiC,
                        title: 'Jam Mulai',
                        isCheck: true,
                        onTap: () async {
                          controller.jamMulaiC.text =
                              await controller.getTime(context);
                        },
                      ),
                    ),
                    // 12.sW,
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        width: 12,
                        child: Divider(
                          thickness: 2,
                          color: ColorApp.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextForm.border(
                        controller: controller.jamBerakhirC,
                        title: 'Jam Berakhir',
                        isCheck: true,
                        onTap: () async {
                          controller.jamBerakhirC.text =
                              await controller.getTime(context);
                        },
                      ),
                    ),
                  ],
                ),
                16.sH,
                TextForm.border(
                  controller: controller.tglC,
                  title: 'Tanggal',
                  textInputType: TextInputType.number,
                  isCheck: true,
                  onTap: () async {
                    controller.tglC.text = await controller.getDate(context);
                  },
                ),
                16.sH,
                Obx(
                  () => ButtonPrymary(
                    text: 'Tambah',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.tambahWaktuPemilihan,
                  ),
                ),
                4.sH,
                const Divider(thickness: 2),
                20.sH,
                const Text(
                  'info : ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                4.sH,
                const Text(
                  'anda tidak bisa menambah waktu pemilihan jika masih ada pemilihan yang berlangsung',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
