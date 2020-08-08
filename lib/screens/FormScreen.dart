import 'dart:io';
import 'package:flutter/material.dart';
import '../screen_components/UploadForm.dart';

class FormScreen extends StatefulWidget {
  final File img;

  FormScreen(this.img);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('New Post'), centerTitle: true),
        body: SingleChildScrollView(child: UploadForm(widget.img)));
  }
}
