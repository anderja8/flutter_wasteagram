import 'package:flutter/material.dart';
import '../models/WastePost.dart';
import '../screen_components/WastePostDetailBody.dart';

class DetailScreen extends StatelessWidget {
  final WastePost wastePost;

  DetailScreen(this.wastePost);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: WastePostDetailBody(wastePost),
    );
  }
}
