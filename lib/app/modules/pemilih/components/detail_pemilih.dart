import 'package:admin_voting/app/core/interface/app_bar/app_bar_actions.dart';
import 'package:admin_voting/app/core/models/pemilih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../routes/app_pages.dart';

class DetailPemilih extends StatelessWidget {
  const DetailPemilih({
    super.key,
    required this.data,
  });

  final PemilihModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarActions(
        title: 'Detail Biodata Pemilih',
        actions: [
          ButtonText(
            'Edit',
            fontSize: 16,
            onTap: () {
              Get.toNamed(
                Routes.FORM_PEMILIH,
                arguments: data,
              );
            },
          ),
          20.sW
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              ListTile(
                title: const Text('Nama :'),
                subtitle:
                    Text('${data.nama}', style: const TextStyle(fontSize: 16)),
              ),
              const Divider(),
              ListTile(
                title: const Text('STB :'),
                subtitle:
                    Text('${data.stb}', style: const TextStyle(fontSize: 16)),
              ),
              const Divider(),
              ListTile(
                title: const Text('Jenis kelamin :'),
                subtitle:
                    Text('${data.jkl}', style: const TextStyle(fontSize: 16)),
              ),
              const Divider(),
              ListTile(
                title: const Text('Jurusan :'),
                subtitle:
                    Text('${data.prody}', style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding carsVisiMisi(e) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 12,
            color: Colors.blue,
          ),
          Text(' $e'),
        ],
      ),
    );
  }
}
