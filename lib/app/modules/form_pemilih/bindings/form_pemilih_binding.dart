import 'package:get/get.dart';

import '../controllers/form_pemilih_controller.dart';

class FormPemilihBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormPemilihController>(
      () => FormPemilihController(),
    );
  }
}
