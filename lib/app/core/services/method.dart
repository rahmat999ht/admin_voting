import 'package:cloud_firestore/cloud_firestore.dart';

import '../constans/constans_app.dart';
import '../models/capres.dart';
import '../models/pemilih.dart';
import '../models/pemilihan.dart';

class MethodApp {
  Future addPemilihan(
    Map<String, dynamic> map, {
    Map<String, dynamic>? data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.pemilihanCollection)
        .add(data!);
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
}
