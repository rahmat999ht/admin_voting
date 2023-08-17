// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class WaktuPemModel {
  final String? id;
  final String periode;
  final bool isAktif;
  final Timestamp waktuMulai;
  final Timestamp waktuSelesai;
  WaktuPemModel({
    this.id,
    required this.periode,
    required this.isAktif,
    required this.waktuMulai,
    required this.waktuSelesai,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'periode': periode,
      'isAktif': isAktif,
      'waktuMulai': waktuMulai,
      'waktuSelesai': waktuSelesai,
    };
  }

  factory WaktuPemModel.fromMapById(String id, Map<String, dynamic> map) {
    return WaktuPemModel(
      id: id,
      periode: map['periode'] as String,
      isAktif: map['isAktif'] as bool,
      waktuMulai: map['waktuMulai'] as Timestamp,
      waktuSelesai: map['waktuSelesai'] as Timestamp,
    );
  }

  factory WaktuPemModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      WaktuPemModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}
