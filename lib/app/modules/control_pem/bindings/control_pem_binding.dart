import 'package:get/get.dart';

import '../controllers/control_pem_controller.dart';

class ControlPemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControlPemController>(
      () => ControlPemController(),
    );
  }
}
