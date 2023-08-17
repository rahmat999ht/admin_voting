import 'package:admin_voting/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
//  with StateMixin<List<RiwayatPem>>
{
  void toFormAddPemilihan() {
    Get.toNamed(Routes.FORM_ADD_PEM);
  }

  void toControlPemilihan() {
    Get.toNamed(Routes.CONTROL_PEM);
  }

  void toInfoApp() {
    Get.toNamed(Routes.INFO_APP);
  }
}
