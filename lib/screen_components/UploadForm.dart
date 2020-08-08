import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class UploadForm extends StatefulWidget {
  final File img;

  UploadForm(this.img);

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final _formKey = GlobalKey<FormState>();
  int numItems = 0;
  LocationData locationData;
  bool savedSuccessfully;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var location = Location();
    locationData = await location.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          imageDisplay(),
          paddedWidget(8.0, numItemsInputField()),
          paddedWidget(8.0, uploadButton())
        ]));
  }

  //Function to save the form data to the firebase db
  void saveForm() async {
    if (_formKey.currentState.validate() && locationData != null) {
      _formKey.currentState.save();

      //Upload the image to firebase storage
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child(widget.img.path);
      StorageUploadTask uploadTask = storageReference.putFile(widget.img);
      await uploadTask.onComplete;
      final imgUrl = await storageReference.getDownloadURL();

      //Upload the document to firestore
      Firestore.instance.collection('wastePosts').document().setData({
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
        'photo_url': '$imgUrl',
        'quantity': numItems,
        'time': DateTime.now()
      });

      //Return to the main page
      Navigator.of(context).pop();
    }
  }

  Widget imageDisplay() {
    return Semantics(
        child: Image.file(widget.img,
            width: MediaQuery.of(context).size.width * 0.5),
        label: 'Picture taken with camera');
  }

  //Function to construct the number of items form field
  Widget numItemsInputField() {
    return Semantics(
        child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
                labelText: 'Number of items', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a number';
              } else if (int.parse(value) < 1) {
                return 'There must be at least one item wasted';
              }
              return null;
            },
            onSaved: (value) {
              numItems = int.parse(value);
            }),
        label: 'Input field.',
        hint: 'Enter the number of items pictured here.');
  }

  //Function to construct the upload button
  Widget uploadButton() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          child: Semantics(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  paddedWidget(8.0, Icon(Icons.cloud_upload)),
                  paddedWidget(8.0, Text('Upload Data'))
                ],
              ),
              label: 'Upload',
              button: true,
              onTapHint: 'Write the form and picture to the server.'),
          onPressed: () {
            //If the locationData variable is null, request the data
            if (locationData == null) {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Error - no location data to send.'),
                        content: Text(
                            'Allow this app access to location services via settings'),
                      ));
            }

            //Otherwise, save and pop
            saveForm();
          },
        ));
  }
}

//Simple function to add some padding around a generic widget
Widget paddedWidget(double padVal, Widget wid) {
  return Padding(padding: EdgeInsets.all(padVal), child: wid);
}
