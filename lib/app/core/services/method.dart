import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constans/constans_app.dart';
import '../models/capres.dart';
import '../models/pemilih.dart';
import '../models/pemilihan.dart';

class MethodApp {
  Future addPemilihan({
    required Map<String, dynamic> data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.pemilihanCollection)
        .add(data);
  }

  Future addPemilih({
    required Map<String, dynamic> data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.pemilihCollection)
        .add(data);
  }

  Future updatePemilih({
    required String idPemilih,
    required Map<String, dynamic> data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.pemilihCollection)
        .doc(idPemilih)
        .update(data);
  }

  Future deletePemilih({
    required String idPemilih,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.pemilihCollection)
        .doc(idPemilih)
        .delete();
  }

  Future addCapres({
    required Map<String, dynamic> data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.capresCollection)
        .add(data);
  }

  Future updateCapres({
    String? idCapres,
    Map<String, dynamic>? data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.capresCollection)
        .doc(idCapres)
        .update(data!);
  }

  Future deleteCapres({
    required String idCapres,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.capresCollection)
        .doc(idCapres)
        .delete();
  }

  DocumentReference<PemilihModel> pemilih(String idPemilih) {
    return ConstansApp.firestore
        .collection(ConstansApp.pemilihCollection)
        .doc(idPemilih)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              PemilihModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  DocumentReference<PemilihanModel> pemilihan(String idPemilihan) {
    return ConstansApp.firestore
        .collection(ConstansApp.pemilihanCollection)
        .doc(idPemilihan)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              PemilihanModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  DocumentReference<CapresModel> capres(String idCapres) {
    return ConstansApp.firestore
        .collection(ConstansApp.capresCollection)
        .doc(idCapres)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              CapresModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  DocumentReference<Map<String, dynamic>> admin(String idAdmin) {
    return ConstansApp.firestore
        .collection(ConstansApp.adminCollection)
        .doc(idAdmin);
    // .withConverter(
    //   fromFirestore: (snapshot, options) =>
    //       AdminModel.fromDocumentSnapshot(snapshot),
    //   toFirestore: (value, options) => value.toMap(),
    // );
  }

  Future<String> uploadWithImage(
    File file,
    String uniqName,
  ) async {
    const String folder = 'profil';
    final uploadTask =
        await ConstansApp.storageRef.child("$folder/$uniqName.jpg").putFile(
              file,
              ConstansApp.metadata,
            );
    final String urlImage = await uploadTask.ref.getDownloadURL();

    return urlImage;
  }
}
