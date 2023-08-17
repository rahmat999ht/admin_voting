import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/colors/colors_app.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? isLogin = prefs.getString("idLogin") ?? '';
  String initialRoutes = isLogin == '' ? Routes.LOGIN : Routes.DASHBOARD;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
      GetMaterialApp(
        title: "Application",
        initialRoute: initialRoutes,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: ColorApp.primary),
      ),
    ),
  );
}
