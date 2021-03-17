import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class AppImagePicker {
  static Future<File> imgFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 60);
    return File(image.path);
  }

 static Future<File> imgFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 60);
    return File(image.path);
  }

  static  void showPicker(context,Function(File) imageRetrive) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                   ListTile(
                      leading: new Icon(Icons.photo_library),
                      title:  Text('photo_library'),
                      onTap: () async {
                        imageRetrive(await AppImagePicker.imgFromGallery());
                        Navigator.of(context).pop();
                      }),
                   ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: Text('camera'),
                    onTap: () async {
                      imageRetrive(await AppImagePicker.imgFromCamera());
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
