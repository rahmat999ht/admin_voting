import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../modules/dashboard/controllers/dashboard_controller.dart';

class ConstansApp {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String pemilihCollection = 'pemilih';
  static String capresCollection = 'capres';
  static String adminCollection = 'admin';
  static String pemilihanCollection = 'pemilihan';
  static String waktuPemilihanCollection = 'waktu_pemilihan';
  static String riwayatPemilihanCollection = 'riwayat_pemilihan';
  static String periodePemilihanCollection = 'periodePemilihan';

  static const String dateFormat = 'dd MMMM yyyy';
  static const String dateTanggalFormat = 'dd/MM/yyyy';

  static final storageRef = FirebaseStorage.instance.ref();

  static final metadata = SettableMetadata(contentType: "image/jpeg");

  static final idLogin = Get.find<DashboardController>().idLoginAdmin;
}
