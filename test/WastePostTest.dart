import 'package:flutter_test/flutter_test.dart';
import '../lib/models/WastePost.dart';

void main() {
  test(
      'Instantiation of WastePost object with all required fields should set those fields.',
      () {
    //Instantiate an object of the class
    double lat = 116.0;
    double long = -54.23454;
    int qnty = 20;
    String identifier = '1234';
    String url = 'iLiveHere';
    DateTime rn = DateTime.now();
    WastePost testPost = WastePost(
        latitude: lat,
        longitude: long,
        quantity: qnty,
        time: rn,
        id: identifier,
        photoUrl: url);

    //Verify
    expect(lat, testPost.latitude);
    expect(long, testPost.longitude);
    expect(qnty, testPost.quantity);
    expect(rn, testPost.time);
    expect(identifier, testPost.id);
    expect(url, testPost.photoUrl);
  });

  test(
      'Instantiation of WastePost object without required fields should set those fields left blank to null.',
      () {
    //Instantiate an object of the class
    double lat = 116.0;
    double long = -54.23454;
    int qnty = 20;
    String identifier = '1234';
    DateTime rn = DateTime.now();
    WastePost testPost = WastePost(
        latitude: lat,
        longitude: long,
        quantity: qnty,
        time: rn,
        id: identifier);

    //Verify
    expect(lat, testPost.latitude);
    expect(long, testPost.longitude);
    expect(qnty, testPost.quantity);
    expect(rn, testPost.time);
    expect(identifier, testPost.id);
    expect(null, testPost.photoUrl);
  });
}
