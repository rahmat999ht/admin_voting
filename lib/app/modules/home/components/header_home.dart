import 'package:admin_voting/app/core/colors/colors_app.dart';
import 'package:admin_voting/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../dashboard/controllers/dashboard_controller.dart';

class HeaderHome extends GetView<DashboardController> {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => GestureDetector(
        onTap: () {
          Get.toNamed(
            Routes.PROFILE,
            arguments: state,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang kembali',
              style: TextStyle(
                color: ColorApp.black,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            8.sH,
            Row(
              children: [
                ClipOval(
                  child: state!.foto == null
                      ? const SizedBox(height: 30)
                      : Image.network(
                          state.foto!,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                ),
                12.sW,
                Text(
                  'admin : ',
                  style: TextStyle(
                    color: ColorApp.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                Text(
                  state.nama!,
                  style: TextStyle(
                    color: ColorApp.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onEmpty: const EmptyState(),
      onLoading: const LoadingState(),
      onError: (e) => ErrorState(error: e!),
    );
  }
}
