import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/interface/app_bar/app_bar_back.dart';
import '../../../core/state/image.dart';
import '../../form_capres/controllers/image_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImagesController());

    return Scaffold(
      appBar: appBarBack(
        title: 'Profil Admin',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.dataAdmin == null)
                  const WrapperImageAdmin(
                    image: null,
                  )
                else
                  WrapperImageAdmin(
                    image: controller.dataAdmin!.foto,
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
                  controller: controller.cJkl,
                  title: 'Jenis Kelamin',
                  isCheck: true,
                  onTap: controller.alertJKL,
                ),
                16.sH,
                TextForm.border(
                  controller: controller.cNoHp,
                  title: 'No. Hp',
                  isCheck: true,
                ),
                16.sH,
                Obx(
                  () => ButtonPrymary(
                    isLoading: controller.isLoading.value,
                    text: 'Simpan',
                    onPressed: controller.save,
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

class WrapperImageAdmin extends GetView<ImagesController> with ImageState {
  const WrapperImageAdmin({
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
