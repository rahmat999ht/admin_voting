import 'dart:developer';

import 'package:admin_voting/app/modules/capres/controllers/capres_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/models/pemilihan.dart';
import '../../pemilih/controllers/pemilih_controller.dart';

class HomeController extends GetxController
    with StateMixin<List<PemilihanModel>> {}
