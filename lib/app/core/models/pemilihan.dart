import 'package:admin_voting/app/core/models/pemilih.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'capres.dart';

class PemilihanModel {
  String? id;
  DocumentReference? capres;
  DocumentReference? pemilih;
  Timestamp? tglMemilih;
  PemilihanModel({
    this.id,
    this.capres,
    this.pemilih,
    this.tglMemilih,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'capres': capres,
      'pemilih': pemilih,
      'tglMemilih': tglMemilih,
    };
  }

  factory PemilihanModel.fromMapById(String id, Map<String, dynamic> map) {
    final dataCapres = map['capres'] as DocumentReference;
    DocumentReference<CapresModel> idCapres = dataCapres.withConverter(
      fromFirestore: (snapshot, options) =>
          CapresModel.fromDocumentSnapshot(snapshot),
      toFirestore: (value, options) => value.toMap(),
    );
    final dataPemilih = map['pemilih'] as DocumentReference;
    DocumentReference<PemilihModel> idPemilih = dataPemilih.withConverter(
      fromFirestore: (snapshot, options) =>
          PemilihModel.fromDocumentSnapshot(snapshot),
      toFirestore: (value, options) => value.toMap(),
    );
    return PemilihanModel(
      id: id,
      capres: idCapres,
      pemilih: idPemilih,
      tglMemilih:
          map['tglMemilih'] != null ? map['tglMemilih'] as Timestamp : null,
    );
  }

  factory PemilihanModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      PemilihanModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}
