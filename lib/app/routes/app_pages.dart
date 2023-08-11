// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/capres/bindings/capres_binding.dart';
import '../modules/capres/views/capres_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pemilih/bindings/pemilih_binding.dart';
import '../modules/pemilih/views/pemilih_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
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
      name: _Paths.CAPRES,
      page: () => const CapresView(),
      binding: CapresBinding(),
    ),
    GetPage(
      name: _Paths.PEMILIH,
      page: () => const PemilihView(),
      binding: PemilihBinding(),
    ),
  ];
}
