import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/FormScreen.dart';

class NewPostFOB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Semantics(
          child: Icon(Icons.camera_alt),
          label: 'Camera',
          button: true,
          onTapHint: 'open the camera app for taking a photo of food waste.'),
      onPressed: () {
        pushFormScreen(context);
      },
    );
  }

  void pushFormScreen(BuildContext context) async {
    File img = await getImage();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FormScreen(img)));
  }
}

Future<File> getImage() async {
  PickedFile img = await ImagePicker().getImage(source: ImageSource.camera);
  return File(img.path);
}
