import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors/colors_app.dart';
import '../../control_pem/controllers/control_pem_controller.dart';
import '../components/hasil.dart';
import '../components/page_button.dart';
import '../components/presentasi.dart';
import '../controllers/statistic_controller.dart';

class StatisticView extends GetView<StatisticController> {
  const StatisticView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ControlPemController>(
      () => ControlPemController(),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorApp.white,
        title: Obx(
          () => PageButton(
            selectionTab: controller.selectionTab.value,
            changeSelectionTab: (index) {
              controller.pageController!.jumpToPage(index);
            },
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: 2,
              onPageChanged: (v) => controller.onPage(v),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Presentasi();
                } else {
                  return const Hasil();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
