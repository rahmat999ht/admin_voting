import 'package:admin_voting/app/core/colors/colors_app.dart';
import 'package:admin_voting/app/modules/pemilih/controllers/pemilih_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

class FormSearch extends GetView<PemilihController> {
  const FormSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        40.sH,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => TextForm(
              isBorder: true,
              radius: 40,
              hintText: "Search STB",
              colorBorder: ColorApp.primary,
              textInputType: TextInputType.number,
              controller: controller.cSearch,
              onChanged: (v) {
                controller.onChange(v);
              },
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: ColorApp.primary,
              ),
              suffixIcon: controller.isSearch.isFalse
                  ? const SizedBox()
                  : IconButton(
                      icon: const Icon(
                        Icons.close_sharp,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        controller.cSearch.clear();
                        controller.isSearch.value = false;
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
