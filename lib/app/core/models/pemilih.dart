import 'package:cloud_firestore/cloud_firestore.dart';

class PemilihModel {
  String? id;
  int? stb;
  String? nama;
  String? jkl;
  String? prody;
  String? pass;
  bool? isMemilih;
  bool? isAktif;
  PemilihModel({
    this.id,
    required this.stb,
    required this.nama,
    required this.jkl,
    required this.prody,
    required this.pass,
    required this.isMemilih,
    required this.isAktif,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stb': stb,
      'nama': nama,
      'jkl': jkl,
      'prody': prody,
      'pass': pass,
      'isMemilih': isMemilih,
      'isAktif': isAktif,
    };
  }

  factory PemilihModel.fromMapById(String id, Map<String, dynamic> map) {
    return PemilihModel(
      id: id,
      stb: map['stb'] != null ? map['stb'] as int : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      jkl: map['jkl'] != null ? map['jkl'] as String : null,
      prody: map['prody'] != null ? map['prody'] as String : null,
      pass: map['pass'] != null ? map['pass'] as String : null,
      isMemilih: map['isMemilih'] != null ? map['isMemilih'] as bool : null,
      isAktif: map['isAktif'] != null ? map['isAktif'] as bool : null,
    );
  }

  factory PemilihModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      PemilihModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}
