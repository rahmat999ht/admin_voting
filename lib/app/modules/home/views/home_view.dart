import 'package:admin_voting/app/modules/home/components/hasil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/page_button.dart';
import '../components/presentasi.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () => PageButton(
              selectionTab: controller.selectionTab.value,
              changeSelectionTab: (index) {
                controller.pageController!.jumpToPage(index);
              },
            ),
          ),
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
