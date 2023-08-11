import 'package:get/get.dart';

import '../controllers/capres_controller.dart';

class CapresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CapresController>(
      () => CapresController(),
    );
  }
}
