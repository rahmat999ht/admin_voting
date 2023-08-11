// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class PeriodePemilihanModel {
  String? id;
  String? periode;
  Timestamp? tglMulai;
  Timestamp? tglBerakhir;
  PeriodePemilihanModel({
    this.id,
    this.periode,
    this.tglMulai,
    this.tglBerakhir,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'periode': periode,
      'tglMulai': tglMulai,
      'tglBerakhir': tglBerakhir,
    };
  }

  factory PeriodePemilihanModel.fromMapById(
      String id, Map<String, dynamic> map) {
    return PeriodePemilihanModel(
      id: id,
      periode: map['periode'] != null ? map['periode'] as String : null,
      tglMulai: map['tglMulai'] != null ? map['tglMulai'] as Timestamp : null,
      tglBerakhir:
          map['tglBerakhir'] != null ? map['tglBerakhir'] as Timestamp : null,
    );
  }

  factory PeriodePemilihanModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      PeriodePemilihanModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}
