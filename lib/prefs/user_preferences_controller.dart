import 'dart:convert';

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

  void save(List<QrCodeModel> history) async {
    final String encodedData = encode(history);

    await _sharedPreferences.setString('historyArray', encodedData);
  }

  List<QrCodeModel> getHistory() {
    if (_sharedPreferences.getString('historyArray') == null) {
      return [];
    } else {
      return decode(_sharedPreferences.getString('historyArray') ?? '');
    }
  }

  Future setLangCode(String langCode) async {
    await _sharedPreferences.setString('codeLang', langCode);
  }

  String getLangCode() {
    return _sharedPreferences.getString('codeLang') ?? 'en';
  }

  Future setSound() async {
    await _sharedPreferences.setBool('sound', !getSound());
  }

  bool getSound() {
    return _sharedPreferences.getBool('sound') ?? true;
  }

  Future setVibrate() async {
    await _sharedPreferences.setBool('vibrate', !getVibrate());
  }

  bool getVibrate() {
    return _sharedPreferences.getBool('vibrate') ?? true;
  }

  Future setCopyAlways() async {
    await _sharedPreferences.setBool('copy', !getCopyAlways());
  }

  bool getCopyAlways() {
    return _sharedPreferences.getBool('copy') ?? false;
  }
}
