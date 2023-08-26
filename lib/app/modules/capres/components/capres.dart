import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../../../core/models/capres.dart';

class Capres extends StatelessWidget {
  final List<CapresModel>? listCapres;
  final int? index;
  final void Function()? onTap;
  final void Function()? onTapDelete;
  const Capres({
    Key? key,
    required this.listCapres,
    required this.index,
    required this.onTap,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final capres = listCapres![index!];
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            leading: ClipOval(
              child: capres.foto == null
                  ? const CircleAvatar(
                      child: SizedBox(height: 30),
                    )
                  : Image.network(
                      capres.foto!,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
            ),
            title: Text(
              capres.nama!,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Geomanist',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              capres.stb.toString(),
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
        if (listCapres!.length == index! + 1)
          Text(
            'List Terakhir ...',
            style: TextStyle(
              fontSize: 14,
              color: ColorApp.primary,
            ),
          ),
        if (listCapres!.length == index! + 1) 40.sH,
      ],
    );
  }
}
