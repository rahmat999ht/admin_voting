import 'package:cloud_firestore/cloud_firestore.dart';

class ConstansApp {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String pemilihCollection = 'pemilih';
  static String capresCollection = 'capres';
  static String adminCollection = 'admin';
  static String pemilihanCollection = 'pemilihan';
  static String periodePemilihanCollection = 'periodePemilihan';

  // static final idLogin = Get.find<DashboardController>().idLoginUser;
}
