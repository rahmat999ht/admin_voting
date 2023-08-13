import 'package:admin_voting/app/core/models/pemilih.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';

class Pemilih extends StatelessWidget {
  final List<PemilihModel>? listPemilih;
  final int? index;
  final void Function()? onTap;
  final void Function()? onLongTap;
  final void Function()? onTapDelete;
  const Pemilih({
    Key? key,
    required this.listPemilih,
    required this.index,
    required this.onTap,
    required this.onLongTap,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pemilih = listPemilih![index!];
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          onLongPress: onLongTap,
          child: ListTile(
            leading: pemilih.isAktif == true
                ? pemilih.isMemilih! == true
                    ? Icon(LineIcons.checkCircleAlt, color: ColorApp.green)
                    : Icon(LineIcons.questionCircle, color: ColorApp.primary)
                : Icon(LineIcons.ban, color: ColorApp.red),
            title: Text(
              pemilih.nama!,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Geomanist',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              pemilih.stb.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Geomanist',
              ),
            ),
            trailing: InkWell(
              onTap: onTapDelete,
              child: Icon(LineIcons.trash, color: ColorApp.red),
            ),
          ),
        ),
        if (listPemilih!.length == index! + 1)
          Text(
            'List Terakhir ...',
            style: TextStyle(
              fontSize: 14,
              color: ColorApp.primary,
            ),
          ),
        if (listPemilih!.length == index! + 1) 40.sH,
      ],
    );
  }
}
