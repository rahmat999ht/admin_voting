import 'package:get/get.dart';

import '../../control_pem/controllers/control_pem_controller.dart';
import '../controllers/form_add_pem_controller.dart';

class FormAddPemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormAddPemController>(
      () => FormAddPemController(),
    );
    Get.lazyPut<ControlPemController>(
      () => ControlPemController(),
    );
  }
}
