// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String? id;
  final String? foto;
  final String? userName;
  final String? pass;
  final String? nama;
  final String? jkl;
  final String? noHp;

  AdminModel({
    this.id,
    this.foto,
    this.userName,
    this.pass,
    this.nama,
    this.jkl,
    this.noHp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foto': foto,
      'userName': userName,
      'pass': pass,
      'nama': nama,
      'jkl': jkl,
      'noHp': noHp,
    };
  }

  factory AdminModel.fromMapById(
    String id,
    Map<String, dynamic> map,
  ) {
    return AdminModel(
      id: map['id'] != null ? map['id'] as String : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      pass: map['pass'] != null ? map['pass'] as String : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      jkl: map['jkl'] != null ? map['jkl'] as String : null,
      noHp: map['noHp'] != null ? map['noHp'] as String : null,
    );
  }

  factory AdminModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      AdminModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}
