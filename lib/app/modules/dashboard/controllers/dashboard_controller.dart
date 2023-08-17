import 'dart:developer';

import 'package:admin_voting/app/core/models/admin.dart';
import 'package:admin_voting/app/modules/capres/views/capres_view.dart';
import 'package:admin_voting/app/modules/pemilih/views/pemilih_view.dart';
import 'package:admin_voting/app/modules/statistic/views/statistic_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constans/constans_app.dart';
import '../../home/views/home_view.dart';

class DashboardController extends GetxController with StateMixin<AdminModel> {
  final selectedIndex = 0.obs;
  List<Widget> widgetOptions() => [
        const HomeView(),
        const StatisticView(),
        const CapresView(),
        const PemilihView(),
      ];
  String idLoginAdmin = '';
  AdminModel? adminModel;
  late final List<AdminModel> dataAdmin;
  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();

    final idLogin = prefs.getString('idLogin');
    log(idLogin!);
    await initData(idLogin);
    selectedIndex.value = 0;
    idLoginAdmin = idLogin;
    super.onInit();
  }

  Future initData(String idLogin) async {
    final dataAllAdmin = await ConstansApp.firestore
        .collection(ConstansApp.adminCollection)
        .get();
    dataAdmin = dataAllAdmin.docs
        .map((e) => AdminModel.fromDocumentSnapshot(e))
        .toList();
    var dataAminModel = dataAllAdmin.docs.firstWhere((e) => e.id == idLogin);
    adminModel = AdminModel.fromDocumentSnapshot(dataAminModel);
    successState(adminModel!);
  }

  void loadingState() {
    change(
      null,
      status: RxStatus.loading(),
    );
  }

  void successState(dynamic userLogin) {
    change(
      userLogin,
      status: RxStatus.success(),
    );
  }
}
