import 'package:cloud_firestore/cloud_firestore.dart';

class PemilihModel {
  String? id;
  int? stb;
  String? nama;
  String? pass;
  bool? isMemilih;
  bool? isAktif;
  PemilihModel({
    this.id,
    required this.stb,
    required this.nama,
    this.pass,
    this.isMemilih,
    this.isAktif,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stb': stb,
      'nama': nama,
      'pass': pass,
      'isMemilih': isMemilih,
      'isAktif': isAktif,
    };
  }

  Map<String, dynamic> toAdd() {
    return <String, dynamic>{
      'stb': stb,
      'nama': nama,
      'pass': pass,
      'isMemilih': isMemilih,
      'isAktif': isAktif,
    };
  }

  Map<String, dynamic> toUpdate() {
    return <String, dynamic>{
      'stb': stb,
      'nama': nama,
    };
  }

  factory PemilihModel.fromMapById(String id, Map<String, dynamic> map) {
    return PemilihModel(
      id: id,
      stb: map['stb'] != null ? map['stb'] as int : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
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
