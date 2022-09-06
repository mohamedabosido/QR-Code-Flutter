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
    update();
    UserPreferencesController().save(history);
  }
}
