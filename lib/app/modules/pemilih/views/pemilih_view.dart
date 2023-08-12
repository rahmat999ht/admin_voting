import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pemilih_controller.dart';

class PemilihView extends GetView<PemilihController> {
  const PemilihView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemilih'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PemilihView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
