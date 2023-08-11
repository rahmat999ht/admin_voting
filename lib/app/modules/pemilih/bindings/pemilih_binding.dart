import 'package:get/get.dart';

import '../controllers/pemilih_controller.dart';

class PemilihBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemilihController>(
      () => PemilihController(),
    );
  }
}
