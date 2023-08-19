import 'package:admin_voting/app/core/models/capres.dart';

class PemilihCapresModel {
  final String noUrut;
  final double bykPemilih;
  final String persen;
  PemilihCapresModel({
    required this.noUrut,
    required this.bykPemilih,
    required this.persen,
  });
}

class CapresTerpilihModel {
  final double jumlahSuara;
  final double nilaiPengali;
  final double nilaiValidasi;
  final String persen;
  final CapresModel capres;
  CapresTerpilihModel({
    required this.capres,
    required this.jumlahSuara,
    required this.nilaiPengali,
    required this.nilaiValidasi,
    required this.persen,
  });
}
