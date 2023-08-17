import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RiwayatPemModel {
  final String id;
  final String periodeTahun;
  final List<DataPemilihan> dataPemilihan;
  RiwayatPemModel({
    required this.id,
    required this.periodeTahun,
    required this.dataPemilihan,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'periodeTahun': periodeTahun,
      'dataPemilihan': dataPemilihan.map((x) => x.toMap()).toList(),
    };
  }

  factory RiwayatPemModel.fromMapById(String id, Map<String, dynamic> map) {
    return RiwayatPemModel(
      id: id,
      periodeTahun: map['periodeTahun'] as String,
      dataPemilihan: List<DataPemilihan>.from(
        (map['dataPemilihan'] as List).map<DataPemilihan>(
          (x) => DataPemilihan.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory RiwayatPemModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      RiwayatPemModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}

class DataPemilihan {
  final int totalPemilih;
  final String stbCapres;
  final String noUrutCapres;
  final String fotoCapres;
  final String namaCapres;
  final String jklCapres;
  final String prodyCapres;
  final String visiCapres;
  final String misiCapres;
  DataPemilihan({
    required this.totalPemilih,
    required this.stbCapres,
    required this.noUrutCapres,
    required this.fotoCapres,
    required this.namaCapres,
    required this.jklCapres,
    required this.prodyCapres,
    required this.visiCapres,
    required this.misiCapres,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalPemilih': totalPemilih,
      'stbCapres': stbCapres,
      'noUrutCapres': noUrutCapres,
      'fotoCapres': fotoCapres,
      'namaCapres': namaCapres,
      'jklCapres': jklCapres,
      'prodyCapres': prodyCapres,
      'visiCapres': visiCapres,
      'misiCapres': misiCapres,
    };
  }

  factory DataPemilihan.fromMap(Map<String, dynamic> map) {
    return DataPemilihan(
      totalPemilih: map['totalPemilih'] as int,
      stbCapres: map['stbCapres'] as String,
      noUrutCapres: map['noUrutCapres'] as String,
      fotoCapres: map['fotoCapres'] as String,
      namaCapres: map['namaCapres'] as String,
      jklCapres: map['jklCapres'] as String,
      prodyCapres: map['prodyCapres'] as String,
      visiCapres: map['visiCapres'] as String,
      misiCapres: map['misiCapres'] as String,
    );
  }
}
