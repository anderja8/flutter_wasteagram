import 'package:flutter/material.dart';
import 'screens/ListScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      home: ListScreen(),
    );
  }
}
