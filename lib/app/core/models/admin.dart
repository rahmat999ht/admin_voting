import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String? id;
  final String? userName;
  final String? pass;
  AdminModel({
    this.id,
    this.userName,
    this.pass,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'pass': pass,
    };
  }

  factory AdminModel.fromMapById(String id, Map<String, dynamic> map) {
    return AdminModel(
      id: id,
      userName: map['userName'] != null ? map['userName'] as String : null,
      pass: map['pass'] != null ? map['pass'] as String : null,
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
