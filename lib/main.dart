import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/view/lunch_screen.dart';
import 'package:flutter_qr/view/main_screen.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferencesController().initSharePreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Stolzl',
        iconTheme: IconThemeData(
          color: kIconColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter QR',
      initialRoute: '/lunch_screen',
      getPages: [
        GetPage(name: '/lunch_screen', page: () => const LunchScreen()),
        GetPage(name: '/main_screen', page: () => const MainScreen()),
      ],
    );
  }
}
