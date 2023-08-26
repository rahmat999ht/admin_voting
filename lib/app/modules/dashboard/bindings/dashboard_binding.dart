import 'package:get/get.dart';

import '../../capres/controllers/capres_controller.dart';
import '../../control_pem/controllers/control_pem_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../pemilih/controllers/pemilih_controller.dart';
import '../../statistic/controllers/statistic_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(
      DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<StatisticController>(
      () => StatisticController(),
    );
    Get.lazyPut<CapresController>(
      () => CapresController(),
    );
    Get.lazyPut<PemilihController>(
      () => PemilihController(),
    );
    Get.lazyPut<ControlPemController>(
      () => ControlPemController(),
    );
  }
}
