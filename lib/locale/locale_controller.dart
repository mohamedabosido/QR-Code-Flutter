import 'package:flutter/cupertino.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:get/get.dart';

class MyLocaleController extends GetxController {
  // ignore: unnecessary_null_comparison
  Locale initLang = UserPreferencesController().getLangCode() == null
      ? Get.deviceLocale!
      : Locale(UserPreferencesController().getLangCode());
  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    UserPreferencesController().setLangCode(codeLang);
    Get.updateLocale(locale);
  }
}
