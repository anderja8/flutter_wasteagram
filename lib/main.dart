import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Does this even do anything?',
      theme: ThemeData.dark(),
      home: POCHome(),
    );
  }
}

class POCHome extends StatefulWidget {
  @override
  _POCHomeState createState() => _POCHomeState();
}

class _POCHomeState extends State<POCHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter POC')),
        body: StreamBuilder(
            stream: Firestore.instance.collection('wastePosts').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return SingleChildScrollView(
                  child: Column(
                children: [
                  Text(
                      'There are ${snapshot.data.documents.length} files in the firebase db.'),
                  Text('ID: ${snapshot.data.documents[0].documentID}'),
                  Text('Lat: ${snapshot.data.documents[0]['latitude']}'),
                ],
              ));
            }));
  }
}
