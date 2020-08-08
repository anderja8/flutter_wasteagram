import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/WastePost.dart';
import '../screens/DetailScreen.dart';

class WastePostListTile extends StatelessWidget {
  final WastePost wastePost;
  final DateFormat formatter = DateFormat('EEEE, MMMM dd, yyyy');

  WastePostListTile(this.wastePost);

  @override
  Widget build(BuildContext context) {
    return Semantics(
        child: ListTile(
            title: Text(formatter.format(wastePost.time)),
            trailing: Text(wastePost.quantity.toString()),
            onTap: () {
              pushDetailScreen(context);
            }),
        label: 'Waste Entry',
        button: true,
        onTapHint: 'view details of this entry');
  }

  void pushDetailScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailScreen(wastePost)));
  }
}
