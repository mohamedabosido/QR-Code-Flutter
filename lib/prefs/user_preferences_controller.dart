import 'dart:convert';

import 'package:flutter_qr/controller/qr_controller.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesController {
  UserPreferencesController._internal();

  static final UserPreferencesController _instance =
      UserPreferencesController._internal();

  late SharedPreferences _sharedPreferences;

  factory UserPreferencesController() {
    return _instance;
  }

  Future<void> initSharePreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String encode(List<QrCodeModel> qrs) => json.encode(
        qrs.map<Map<String, dynamic>>((qr) => QrCodeModel.toMap(qr)).toList(),
      );

  static List<QrCodeModel> decode(String qr) =>
      (json.decode(qr) as List<dynamic>)
          .map<QrCodeModel>((item) => QrCodeModel.fromJson(item))
          .toList();

  void save() async {
    final String encodedData = encode(QrController().history);

    await _sharedPreferences.setString('historyArray', encodedData);
  }

  List<QrCodeModel> getHistory() {
    if (_sharedPreferences.getString('historyArray') == null) {
      return [];
    } else {
      return decode(_sharedPreferences.getString('historyArray') ?? '');
    }
  }
}
