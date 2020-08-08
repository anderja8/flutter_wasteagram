import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/WastePost.dart';

class WastePostDetailBody extends StatelessWidget {
  final WastePost wastePost;
  final DateFormat formatter = DateFormat('E, MMM dd, yyyy');

  WastePostDetailBody(this.wastePost);

  @override
  Widget build(BuildContext context) {
    double childPadding = 16.0;

    return SingleChildScrollView(
        child: Align(
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  paddedWidget(childPadding, timeHeadline(context)),
                  paddedWidget(childPadding, imgContainer(context)),
                  paddedWidget(childPadding, numItemsDisplay(context)),
                  paddedWidget(childPadding, locationDisplay(context)),
                ])));
  }

  Widget timeHeadline(BuildContext context) {
    return Semantics(
        child: Text(formatter.format(wastePost.time),
            style: Theme.of(context).textTheme.headline3),
        label: 'Date of post');
  }

  Widget imgContainer(BuildContext context) {
    return Semantics(
        child: Image.network(wastePost.photoUrl,
            width: MediaQuery.of(context).size.width * 0.7, loadingBuilder:
                (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return CircularProgressIndicator();
        }),
        label: 'Image associated with this waste post');
  }

  Widget numItemsDisplay(BuildContext context) {
    return Semantics(
        child: Text('${wastePost.quantity} items'),
        label: 'Number of items associated with this post');
  }

  Widget locationDisplay(BuildContext context) {
    return Semantics(
        child:
            Text('Location: (${wastePost.latitude}, ${wastePost.longitude})'),
        label: 'latitude and longitude');
  }
}

Widget paddedWidget(double padVal, Widget wid) {
  return Padding(padding: EdgeInsets.all(padVal), child: wid);
}
