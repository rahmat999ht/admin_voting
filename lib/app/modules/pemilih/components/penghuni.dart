import 'package:admin_voting/app/core/models/pemilih.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/colors/colors_app.dart';

class Pemilih extends StatelessWidget {
  final List<PemilihModel>? listPemilih;
  final int? index;
  final bool data;
  final void Function()? onTap;
  const Pemilih({
    Key? key,
    required this.listPemilih,
    required this.index,
    required this.onTap,
  })  : data = true,
        super(key: key);
  const Pemilih.nullValue({
    Key? key,
  })  : data = false,
        listPemilih = null,
        index = null,
        onTap = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final pemilih = listPemilih![index!];
    return Column(
      children: [
        InkWell(
          onTap: data ? onTap : null,
          child: ListTile(
              title: Text(
                data ? pemilih.nama! : ' - ',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Geomanist',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                data ? pemilih.stb.toString() : ' - ',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Geomanist',
                ),
              ),
              trailing: data
                  ? pemilih.isMemilih! == true
                      ? const Icon(LineIcons.checkCircle)
                      : const Icon(LineIcons.cross)
                  : const SizedBox()),
        ),
        if (listPemilih!.length == index! + 1)
          Text(
            'List Terakhir ...',
            style: TextStyle(
              fontSize: 14,
              color: ColorApp.primary,
            ),
          ),
      ],
    );
  }
}
