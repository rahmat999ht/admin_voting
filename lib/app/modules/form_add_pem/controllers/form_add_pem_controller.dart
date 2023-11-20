import 'dart:developer';

import 'package:admin_voting/app/core/constans/constans_app.dart';
import 'package:admin_voting/app/core/interface/alerts/alert_info.dart';
import 'package:admin_voting/app/core/models/waktu_pemilihan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/services/method.dart';
import '../../control_pem/controllers/control_pem_controller.dart';

class FormAddPemController extends GetxController {
  final methodApp = MethodApp();
  final isLoading = false.obs;
  DateTime date = DateTime.now();
  final dataWaktuPem = Get.find<ControlPemController>();

  final formKey = GlobalKey<FormState>();
  final jamMulaiC = TextEditingController();
  final jamBerakhirC = TextEditingController();
  final tglC = TextEditingController();

  String title = '';

  void initLoading() {
    isLoading.value = !isLoading.value;
  }

  void tambahWaktuPemilihan() {
    try {
      if (formKey.currentState!.validate()) {
        initLoading();
        if (dataWaktuPem.listWaktuPemilihanModel.isNotEmpty) {
          log('masuk');
          // Konversi jamMulaiText ke dalam format DateTime
          TimeOfDay jamMulai = TimeOfDay(
            hour: int.parse(jamMulaiC.text.split(':')[0]),
            minute: int.parse(jamMulaiC.text.split(':')[1]),
          );

          TimeOfDay jamBerakhir = TimeOfDay(
            hour: int.parse(jamBerakhirC.text.split(':')[0]),
            minute: int.parse(jamBerakhirC.text.split(':')[1]),
          );

          DateFormat inputFormat = DateFormat("dd MMMM yyyy", "id_ID");
          DateTime tanggal = inputFormat.parse(tglC.text);

          // Gabungkan tanggal dan waktu menjadi satu DateTime
          DateTime tglMulai = DateTime(
            tanggal.year,
            tanggal.month,
            tanggal.day,
            jamMulai.hour,
            jamMulai.minute,
          );
          DateTime tglBerakhir = DateTime(
            tanggal.year,
            tanggal.month,
            tanggal.day,
            jamBerakhir.hour,
            jamBerakhir.minute,
          );

          // Konversi DateTime menjadi Timestamp
          Timestamp tsTglMulai = Timestamp.fromDate(tglMulai);
          Timestamp tsTglBerakhir = Timestamp.fromDate(tglBerakhir);
          final mulai = (date.year).toString();
          final berakhir = (date.year + 1).toString();
          final data = WaktuPemModel(
            periode: "$mulai - $berakhir",
            isAktif: true,
            waktuMulai: tsTglMulai,
            waktuSelesai: tsTglBerakhir,
          ).toMap();
          methodApp.addWaktuPemilihan(data: data);
          // log(data.toString());
          jamBerakhirC.clear();
          jamMulaiC.clear();
          tglC.clear();
          Get.back();
          initLoading();
        } else {
          if (dataWaktuPem.listWaktuPemilihanAktif.isNotEmpty) {
            log('tidak di izinkan');
            alertInfo('Maaf', 'Masih ada pemilihan yang berlangsung');
            initLoading();
            return;
          }
        }
      }
    } catch (e) {
      log(e.toString());
      initLoading();
    }
  }

  Future<String> getTime(
    BuildContext context,
  ) async {
    final data = await selectTime(context, TimeOfDay.now());
    if (data != null) {
      final hour = data.hour.toString().padLeft(2, '0');
      final minute = data.minute.toString().padLeft(2, '0');
      final formattedTime = "$hour : $minute";
      return formattedTime;
    }

    return "";
  }

  Future<TimeOfDay?> selectTime(
    BuildContext context,
    TimeOfDay initialDate,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      helpText: "Pilih Waktu",
      cancelText: "BATAL",
      confirmText: "OKE",
      hourLabelText: "Jam",
      minuteLabelText: "Menit",
      initialTime: initialDate,
    );
    if (picked != null && picked != initialDate) {
      return picked;
    }
    return null;
  }

  Future<String> getDate(BuildContext context, [bool isTanggal = false]) async {
    final data = await selectDate(context, DateTime.now());
    if (data != null) {
      final dateFormatter = DateFormat(ConstansApp.dateFormat, "id_ID");
      final dateTanggalFormatter =
          DateFormat(ConstansApp.dateTanggalFormat, "id_ID");
      final formattedDate = isTanggal
          ? dateTanggalFormatter.format(data)
          : dateFormatter.format(data);
      return formattedDate;
    }
    return "";
  }

  static Future<DateTime?> selectDate(
    BuildContext context,
    DateTime initialDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }
}
