import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/view/locale/locale.dart';
import 'package:flutter_qr/view/locale/locale_controller.dart';
import 'package:flutter_qr/view/lunch_screen.dart';
import 'package:flutter_qr/view/main_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferencesController().initSharePreferences();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocaleController controller = Get.put(MyLocaleController());
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: UserPreferencesController().getLangCode() == 'en'
            ? 'Stolzl'
            : 'Changa',
        iconTheme: IconThemeData(
          color: kIconColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter QR',
      initialRoute: '/lunch_screen',
      locale: controller.initLang,
      translations: MyLocale(),
      getPages: [
        GetPage(name: '/lunch_screen', page: () => const LunchScreen()),
        GetPage(name: '/main_screen', page: () => const MainScreen()),
      ],
    );
  }
}
