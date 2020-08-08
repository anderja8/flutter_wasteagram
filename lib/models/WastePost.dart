import 'package:flutter/foundation.dart';

class WastePost {
  final double latitude, longitude;
  final String id, photoUrl;
  final int quantity;
  final DateTime time;

  WastePost(
      {@required this.latitude,
      @required this.longitude,
      this.id,
      this.photoUrl,
      @required this.quantity,
      @required this.time});
}
