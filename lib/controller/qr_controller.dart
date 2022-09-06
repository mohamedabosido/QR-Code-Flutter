import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:get/get.dart';

class QrController extends GetxController {
  List<QrCodeModel> history = UserPreferencesController().getHistory();

  void add({required QrCodeModel qr}) {
    history.add(qr);
    update();
    UserPreferencesController().save(history);
  }

  void delete({required QrCodeModel qr}) {
    history.remove(qr);
    Get.snackbar(
      'Deleted Qr Code',
      qr.url,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(kDefaultPadding),
    );
    update();
    UserPreferencesController().save(history);
  }
}
