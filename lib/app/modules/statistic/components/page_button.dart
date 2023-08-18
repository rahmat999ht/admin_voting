import 'package:admin_voting/app/core/colors/colors_app.dart';
import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  const PageButton({
    Key? key,
    required this.changeSelectionTab,
    required this.selectionTab,
  }) : super(key: key);

  final void Function(int index) changeSelectionTab;
  final int selectionTab;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      color: ColorApp.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        side: BorderSide(
          color: ColorApp.primary,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: buttonTapBar(
              changeSelectionTab: () => changeSelectionTab(0),
              context: context,
              index: 0,
              activeColor: Colors.blue,
              color: Colors.white,
              title: "Hasil sementara",
            ),
          ),
          Expanded(
            child: buttonTapBar(
              changeSelectionTab: () => changeSelectionTab(1),
              context: context,
              activeColor: Colors.blue,
              color: Colors.white,
              index: 1,
              title: "Hasil akhir",
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonTapBar(
      {required BuildContext context,
      required int index,
      required Color activeColor,
      required Color color,
      required String title,
      required VoidCallback changeSelectionTab}) {
    return SizedBox(
      height: 36,
      width: double.maxFinite,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeSelectionTab,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: selectionTab == index ? Colors.black : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
