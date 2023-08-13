import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../controllers/form_pemilih_controller.dart';

class FormPemilih extends GetView<FormPemilihController> {
  const FormPemilih({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextForm.border(
                controller: controller.cNama,
                title: 'Nama',
                isCheck: true,
              ),
              16.sH,
              TextForm.border(
                controller: controller.cStb,
                title: 'STB',
                textInputType: TextInputType.number,
                isCheck: true,
              ),
              16.sH,
              TextForm.border(
                controller: controller.cJkl,
                title: 'Jenis Kelamin',
                isCheck: true,
                onTap: controller.alertJKL,
              ),
              16.sH,
              TextForm.border(
                controller: controller.cProdi,
                title: 'Program Studi',
                isCheck: true,
                onTap: controller.alertProdi,
              ),
              16.sH,
              if (controller.dataPemilih == null)
                ButtonPrymary(
                  text: 'Tambah',
                  onPressed: controller.tambahPemilih,
                )
              else
                ButtonPrymary(
                  text: 'Edit',
                  onPressed: () {
                    controller.editPemilih(
                      controller.dataPemilih!.id!,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
