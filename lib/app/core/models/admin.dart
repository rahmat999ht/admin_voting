import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AdminModel {
  final String? id;
  final String? userName;
  final String? pass;
  final String? nama;
  final String? jkl;
  AdminModel({
    this.id,
    this.userName,
    this.pass,
    this.nama,
    this.jkl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'pass': pass,
      'nama': nama,
      'jkl': jkl,
    };
  }

  factory AdminModel.fromMapById(
    String id,
    Map<String, dynamic> map,
  ) {
    return AdminModel(
      id: id,
      userName: map['userName'] != null ? map['userName'] as String : null,
      pass: map['pass'] != null ? map['pass'] as String : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      jkl: map['jkl'] != null ? map['jkl'] as String : null,
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
