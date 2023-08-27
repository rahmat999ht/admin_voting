import 'package:admin_voting/app/core/interface/app_bar/app_bar_back.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../controllers/info_app_controller.dart';

class InfoAppView extends GetView<InfoAppController> {
  const InfoAppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBack(title: 'Info App'),
      body: Column(children: [
        Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                width: 2,
                color: ColorApp.primary,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                LineIcons.userEdit,
                color: ColorApp.primary,
                size: 100,
              ),
            ),
          ),
        ),
        20.sH,
        const ListTile(
          title: Text('Nama App :'),
          subtitle: Text(
            'admin Voting',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const Divider(),
        const ListTile(
          title: Text('Versi :'),
          subtitle: Text(
            '1.0.0',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text('di buat oleh :'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.sH,
              const Text(
                '[191146] Litha Liga Pangala',
                style: TextStyle(fontSize: 16),
              ),
              4.sH,
              const Text(
                '[191058] Nahda Nurul Ain',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
