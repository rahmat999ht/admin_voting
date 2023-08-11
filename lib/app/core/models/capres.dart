// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class CapresModel {
  String? id;
  int? stb;
  String? noUrut;
  // ImageHash? foto;
  String? foto;
  String? nama;
  String? jkl;
  String? prody;
  List<dynamic>? visi;
  List<dynamic>? misi;
  String? pass;
  CapresModel({
    this.id,
    required this.stb,
    required this.noUrut,
    required this.foto,
    required this.nama,
    required this.jkl,
    required this.prody,
    required this.visi,
    required this.misi,
    required this.pass,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stb': stb,
      'noUrut': noUrut,
      'foto': foto,
      'nama': nama,
      'jkl': jkl,
      'prody': prody,
      'visi': visi,
      'misi': misi,
      'pass': pass,
    };
  }

  factory CapresModel.fromMapById(String id, Map<String, dynamic> map) {
    return CapresModel(
      id: id,
      stb: map['stb'] != null ? map['stb'] as int : null,
      noUrut: map['noUrut'] != null ? map['noUrut'] as String : null,
      // foto: map['foto'] != null
      //     ? ImageHash.fromMap(map['foto'] as Map<String, dynamic>)
      //     : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      jkl: map['jkl'] != null ? map['jkl'] as String : null,
      prody: map['prody'] != null ? map['prody'] as String : null,
      visi: map['visi'] != null
          ? List<dynamic>.from((map['visi'] as List<dynamic>).cast<String>())
          : null,
      misi: map['misi'] != null
          ? List<dynamic>.from((map['misi'] as List<dynamic>).cast<String>())
          : null,
      pass: map['pass'] != null ? map['pass'] as String : null,
    );
  }

  factory CapresModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      CapresModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}
