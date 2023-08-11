import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/capres_controller.dart';

class CapresView extends GetView<CapresController> {
  const CapresView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CapresView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CapresView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
