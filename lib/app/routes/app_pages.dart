import 'package:get/get.dart';

import '../modules/capres/views/capres_view.dart';
import '../modules/control_pem/bindings/control_pem_binding.dart';
import '../modules/control_pem/views/control_pem_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/form_add_pem/bindings/form_add_pem_binding.dart';
import '../modules/form_add_pem/views/form_add_pem_view.dart';
import '../modules/form_capres/bindings/form_capres_binding.dart';
import '../modules/form_capres/views/form_capres_view.dart';
import '../modules/form_pemilih/bindings/form_pemilih_binding.dart';
import '../modules/form_pemilih/views/form_pemilih_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/info_app/bindings/info_app_binding.dart';
import '../modules/info_app/views/info_app_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pemilih/views/pemilih_view.dart';
import '../modules/statistic/views/statistic_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.STATISTIC,
      page: () => const StatisticView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CAPRES,
      page: () => const CapresView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PEMILIH,
      page: () => const PemilihView(),
      binding: DashboardBinding(),
    ),
    // GetPage(
    //   name: _Paths.PROFILE,
    //   page: () => const ProfileView(),
    //   binding: DashboardBinding(),
    // ),
    GetPage(
      name: _Paths.FORM_PEMILIH,
      page: () => const FormPemilih(),
      binding: FormPemilihBinding(),
    ),
    GetPage(
      name: _Paths.FORM_CAPRES,
      page: () => const FormCapresView(),
      binding: FormCapresBinding(),
    ),
    GetPage(
      name: _Paths.FORM_ADD_PEM,
      page: () => const FormAddPemView(),
      binding: FormAddPemBinding(),
    ),
    GetPage(
      name: _Paths.CONTROL_PEM,
      page: () => const ControlPemView(),
      binding: ControlPemBinding(),
    ),
    GetPage(
      name: _Paths.INFO_APP,
      page: () => const InfoAppView(),
      binding: InfoAppBinding(),
    ),
  ];
}
