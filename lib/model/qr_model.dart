import 'package:cloud_firestore/cloud_firestore.dart';

class QrCodeModel {
  late String id;
  late String type;
  late String url;
  late Timestamp time;

  QrCodeModel({
    required this.url,
    required this.type,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['url'] = url;
    map['time'] = time;
    return map;
  }

  QrCodeModel.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'];
    type = map['type'];
    url = map['url'];
    time = map['time'];
  }
}
