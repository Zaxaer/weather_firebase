import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataWeatherWidgetModel extends ChangeNotifier {
  String dataValue = '';
  Future<void> deleteDataWeather(
      int index, AsyncSnapshot<QuerySnapshot> snapshot) async {
    FirebaseFirestore.instance
        .collection('weather_item')
        .doc(snapshot.data!.docs[index].id)
        .delete();
  }

  String value(int index, String path, AsyncSnapshot<QuerySnapshot> snapshot) {
    return dataValue = snapshot.data!.docs[index].get(path).toString();
  }
}
