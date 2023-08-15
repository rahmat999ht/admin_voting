import 'package:get/get.dart';

import '../controllers/form_capres_controller.dart';

class FormCapresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormCapresController>(
      () => FormCapresController(),
    );
  }
}
