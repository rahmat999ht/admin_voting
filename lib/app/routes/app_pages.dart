import 'package:get/get.dart';

import '../modules/capres/views/capres_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/form_capres/bindings/form_capres_binding.dart';
import '../modules/form_capres/views/form_capres_view.dart';
import '../modules/form_pemilih/bindings/form_pemilih_binding.dart';
import '../modules/form_pemilih/views/form_pemilih_view.dart';
import '../modules/home/views/home_view.dart';
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
  ];
}
