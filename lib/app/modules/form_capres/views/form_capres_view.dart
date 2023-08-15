import 'package:collection_ext/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/state/image.dart';
import '../controllers/form_capres_controller.dart';
import '../controllers/image_controller.dart';

class FormCapresView extends GetView<FormCapresController> {
  const FormCapresView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImagesController());
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nomor Urut : "),
                  16.sH,
                  if (controller.dataCapres == null)
                    Text(
                      '   ${controller.noUrut}',
                      style: const TextStyle(fontSize: 30),
                    )
                  else
                    Text(
                      '   ${controller.cNoUrut.text}',
                      style: const TextStyle(fontSize: 30),
                    ),
                  if (controller.dataCapres == null)
                    const WrapperImageUpdateProfil(
                      image: null,
                    )
                  else
                    WrapperImageUpdateProfil(
                      image: controller.dataCapres!.foto,
                    ),
                  16.sH,
                  const Text("Biodata :"),
                  16.sH,
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
                  20.sH,
                  const Text("Visi :"),
                  ...controller.listFormVisi
                      .mapIndexed(
                        (i, e) => Column(
                          children: [
                            16.sH,
                            TextForm.border(
                              controller: e,
                              title: 'Visi ${i + 1}',
                              isCheck: true,
                              suffixIcon: deleteVisi(e),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  ButtonOutline(
                    onPressed: controller.addFormVisi,
                    text: "Tambah Visi",
                  ),
                  20.sH,
                  const Text("Misi :"),
                  ...controller.listFormMisi
                      .mapIndexed(
                        (i, e) => Column(
                          children: [
                            16.sH,
                            TextForm.border(
                              controller: e,
                              title: 'Misi ${i + 1}',
                              isCheck: true,
                              suffixIcon: deleteMisi(e),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  ButtonOutline(
                    onPressed: controller.addFormMisi,
                    text: "Tambah Misi",
                  ),
                  16.sH,
                  if (controller.dataCapres == null)
                    Obx(
                      () => ButtonPrymary(
                        isLoading: controller.isLoading.value,
                        text: 'Tambah',
                        onPressed: controller.tambahCapres,
                      ),
                    )
                  else
                    Obx(
                      () => ButtonPrymary(
                        isLoading: controller.isLoading.value,
                        text: 'Edit',
                        onPressed: () async {
                          await controller.editCapres(
                            controller.dataCapres!.id!,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteVisi(TextEditingController e) {
    if (controller.listFormVisi.length > 2) {
      return InkWell(
        onTap: () {
          controller.deleteFormVisi(e);
        },
        child: const Icon(Icons.close),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget deleteMisi(TextEditingController e) {
    if (controller.listFormMisi.length > 2) {
      return InkWell(
        onTap: () {
          controller.deleteFormMisi(e);
        },
        child: const Icon(Icons.close),
      );
    } else {
      return const SizedBox();
    }
  }
}

class WrapperImageUpdateProfil extends GetView<ImagesController>
    with ImageState {
  const WrapperImageUpdateProfil({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Center(
        child: imageUpdateProfilSucces(
          state!,
          controller.getImage,
        ),
      ),
      onEmpty: Center(
        child: imageUpdateProfilEmpty(
          image,
          controller.getImage,
        ),
      ),
    );
  }
}
