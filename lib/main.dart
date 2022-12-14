import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/view/auth/auth_screen.dart';
import 'package:flutter_qr/view/auth/forget_password_screen.dart';
import 'package:flutter_qr/view/auth/login_screen.dart';
import 'package:flutter_qr/view/auth/sign_up_screen.dart';
import 'package:flutter_qr/view/auth/verify_screen.dart';
import 'package:flutter_qr/view/lunch_screen.dart';
import 'package:flutter_qr/view/main_screen.dart';
import 'package:flutter_qr/view/vcard_form.dart';
import 'package:get/get.dart';
import 'package:flutter_qr/locale/locale.dart';
import 'package:flutter_qr/locale/locale_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferencesController().initSharePreferences();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
  ));
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocaleController controller = Get.put(MyLocaleController());
    return GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      theme: ThemeData(
        fontFamily: UserPreferencesController().getLangCode() == 'en'
            ? 'Stolzl'
            : 'Changa',
        iconTheme: IconThemeData(
          color: kIconColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'QR Code Scanner',
      initialRoute: '/lunch_screen',
      locale: controller.initLang,
      translations: MyLocale(),
      getPages: [
        GetPage(name: '/lunch_screen', page: () => const LunchScreen()),
        GetPage(name: '/auth_screen', page: () => const AuthScreen()),
        GetPage(name: '/login_screen', page: () => const LoginScreen()),
        GetPage(name: '/sign_up_screen', page: () => const SignUpScreen()),
        GetPage(
            name: '/forget_password_screen',
            page: () => ForgetPasswordScreen()),
        GetPage(name: '/verify_screen', page: () => const VerifyScreen()),
        GetPage(name: '/main_screen', page: () => const MainScreen()),
        GetPage(name: '/vcard_screen', page: () => VCardScreen()),
      ],
    );
  }
}
