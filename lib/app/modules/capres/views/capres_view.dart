import 'package:admin_voting/app/modules/capres/components/form_search.dart';
import 'package:admin_voting/app/modules/statistic/components/detail_capres.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../../../core/models/capres.dart';
import '../../../routes/app_pages.dart';
import '../components/capres.dart';
import '../controllers/capres_controller.dart';

class CapresView extends GetView<CapresController> {
  const CapresView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.white,
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: const FormSearchCapres(),
      ),
      body: controller.obx(
        (state) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state!.length,
            itemBuilder: (
              context,
              index,
            ) {
              final CapresModel dataCapres = state[index];
              return Capres(
                listCapres: state,
                index: index,
                onTap: () {
                  Get.to(
                    DetailCapres(
                      data: dataCapres,
                      lengthCapres: controller.lengthCapres,
                    ),
                  );
                },
                onTapDelete: () {
                  controller.alertDeleteCapres(dataCapres);
                },
              );
            },
          );
        },
        onEmpty: const EmptyState(),
        onLoading: const LoadingState(),
        onError: (e) => ErrorState(error: e!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(
            Routes.FORM_CAPRES,
            arguments: {
              'data': null,
              'length': controller.lengthCapres,
            },
          );
        },
        label: Row(
          children: [
            const Icon(LineIcons.plus),
            8.sW,
            const Text('Capres'),
          ],
        ),
      ),
    );
  }
}
