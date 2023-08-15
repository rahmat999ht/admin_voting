import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

import '../colors/colors_app.dart';
import '../interface/card/card_icon.dart';

mixin ImageState {
  TextButton imageEmpty(dynamic getImg) {
    return TextButton(
      onPressed: () async => await getImg(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: const Icon(
          LineIcons.retroCamera,
          size: 100,
        ),
      ),
    );
  }

  Widget imageUpdateProfilEmpty(String? image, dynamic getImage) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        if (image == null)
          SizedBox(
            height: 180,
            width: 180,
            child: Icon(
              LineIcons.userCircle,
              size: 200,
              color: ColorApp.primary,
            ),
          )
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              image,
              height: 180,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
        InkWell(
          onTap: () async => await getImage(),
          //go to camera
          child: CardIcon(
            icon: LineIcons.camera,
            radius: 30,
            height: 54,
            width: 54,
            color: ColorApp.green,
          ),
        ),
      ],
    );
  }

  Widget imageUpdateProfilSucces(List<XFile> state, dynamic getImage) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Image.file(
            File(state.first.path),
            fit: BoxFit.cover,
            height: 180,
            width: 180,
          ),
        ),
        InkWell(
          onTap: () async => await getImage(),
          //go to camera
          child: CardIcon(
            icon: LineIcons.camera,
            radius: 30,
            height: 54,
            width: 54,
            color: ColorApp.primary,
          ),
        ),
      ],
    );
  }

  Widget imageSuccess(List<XFile> state, void Function(int) removeImage) {
    return Container(
      height: 108,
      width: double.infinity,
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        reverse: false,
        scrollDirection: Axis.horizontal,
        itemCount: state.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6, right: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(state.first.path),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  removeImage(index);
                },
                child: ClipOval(
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    color: ColorApp.white,
                    child: Icon(
                      Icons.cancel,
                      color: ColorApp.primary,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 12,
          );
        },
      ),
    );
  }
}
