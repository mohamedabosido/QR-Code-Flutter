import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyLocaleController extends GetxController {
  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    Get.updateLocale(locale);
  }
}
