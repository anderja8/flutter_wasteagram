import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/WastePost.dart';
import '../screen_components/NewPostFOB.dart';
import '../screen_components/WastePostListTile.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int totalItems = 0;
  List<WastePost> wastePosts;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('wastePosts').snapshots(),
        builder: (context, snapshot) {
          // First, initialize the wastePosts map with the documents
          // It would be kinder on the database and app performance to refresh on
          // demand, but using the stream should be fine for our purposes
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            totalItems = 0;
            wastePosts = [];
            for (var doc in snapshot.data.documents) {
              wastePosts.add(WastePost(
                id: doc.documentID,
                latitude: doc['latitude'].toDouble(),
                longitude: doc['longitude'].toDouble(),
                photoUrl: doc['photo_url'],
                quantity: doc['quantity'],
                time: doc['time'].toDate(),
              ));
              totalItems += doc['quantity'];
            }
            wastePosts.sort((a, b) => b.time.compareTo(a.time));
          }

          //Now, use the data initialized above to build the page
          //If the snapshot has no data, return a scaffold with progress indicator
          if (!snapshot.hasData || snapshot.data.documents.length == 0) {
            return Scaffold(
              appBar: AppBar(
                  title: Text('Wasteagram - $totalItems'), centerTitle: true),
              body: Center(child: CircularProgressIndicator()),
              floatingActionButton: NewPostFOB(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }

          //Otherwise, build a listView
          return Scaffold(
            appBar: AppBar(
                title: Text('Wasteagram - $totalItems'), centerTitle: true),
            body: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, idx) {
                  return WastePostListTile(wastePosts[idx]);
                }),
            floatingActionButton: NewPostFOB(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}
