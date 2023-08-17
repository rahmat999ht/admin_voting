import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/info_app_controller.dart';

class InfoAppView extends GetView<InfoAppController> {
  const InfoAppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoAppView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InfoAppView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
