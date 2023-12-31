import 'package:admin_voting/app/core/models/waktu_pemilihan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'capres.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RiwayatPemModel {
  final String? id;
  final Timestamp createAt;
  final DocumentReference periodeTahun;
  final List<DataPemilihan> dataPemilihan;
  RiwayatPemModel({
    this.id,
    required this.createAt,
    required this.periodeTahun,
    required this.dataPemilihan,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createAt': createAt,
      'periodeTahun': periodeTahun,
      'dataPemilihan': dataPemilihan.map((x) => x.toMap()).toList(),
    };
  }

  factory RiwayatPemModel.fromMapById(String id, Map<String, dynamic> map) {
    final dataCapres = map['periodeTahun'] as DocumentReference;
    DocumentReference<WaktuPemModel> idWaktuPemilihan =
        dataCapres.withConverter(
      fromFirestore: (snapshot, options) =>
          WaktuPemModel.fromDocumentSnapshot(snapshot),
      toFirestore: (value, options) => value.toMap(),
    );
    return RiwayatPemModel(
      id: id,
      createAt: map['createAt'] as Timestamp,
      periodeTahun: idWaktuPemilihan,
      dataPemilihan: List<DataPemilihan>.from(
        (map['dataPemilihan'] as List).map<DataPemilihan>(
          (x) => DataPemilihan.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory RiwayatPemModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      RiwayatPemModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}

class DataPemilihan {
  final int totalPemilih;
  final DocumentReference<CapresModel> idCapres;

  DataPemilihan({
    required this.totalPemilih,
    required this.idCapres,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalPemilih': totalPemilih,
      'idCapres': idCapres,
    };
  }

  factory DataPemilihan.fromMap(Map<String, dynamic> map) {
    final dataCapres = map['idCapres'] as DocumentReference;
    DocumentReference<CapresModel> idCapres = dataCapres.withConverter(
      fromFirestore: (snapshot, options) =>
          CapresModel.fromDocumentSnapshot(snapshot),
      toFirestore: (value, options) => value.toMap(),
    );
    return DataPemilihan(
      totalPemilih: map['totalPemilih'] as int,
      idCapres: idCapres,
    );
  }
}
