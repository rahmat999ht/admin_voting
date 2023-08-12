import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/models/capres.dart';

class CapresController extends GetxController
    with StateMixin<List<CapresModel>> {
  List<CapresModel> listCapresModel = [];

  Stream<QuerySnapshot<Map<String, dynamic>>> get getListCapres =>
      ConstansApp.firestore
          .collection(ConstansApp.capresCollection)
          .snapshots();

  @override
  void onInit() {
    getListCapres.listen((event) {
      if (event.size != 0) {
        listCapresModel = List.generate(
          event.docs.length,
          (index) => CapresModel.fromDocumentSnapshot(event.docs[index]),
        ).toList();
        listCapresModel.sort(
          (a, b) => a.noUrut!.compareTo(b.noUrut!),
        );
        log('${listCapresModel.length}', name: 'Capres');
        change(listCapresModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'Capres');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
