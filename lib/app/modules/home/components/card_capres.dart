import 'package:flutter/material.dart';
import 'package:packages/extensions/size_app.dart';

import '../../../core/models/capres.dart';

class CardCapresPV extends StatelessWidget {
  const CardCapresPV({
    Key? key,
    required this.data,
    required this.onTap,
    required this.colors,
    required this.persen,
  }) : super(key: key);
  final CapresModel data;
  final Color colors;
  final String? persen;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        width: 130,
        // height: 125,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${data.nama}",
              style: const TextStyle(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            5.sH,
            ClipOval(
              child: Image.network(
                "${data.foto}",
                fit: BoxFit.cover,
                height: 70,
                width: 70,
              ),
            ),
            5.sH,
            Card(
              color: colors,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(persen ?? '0%'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
