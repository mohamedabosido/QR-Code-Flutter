import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/locale/locale_controller.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppAppBar extends StatelessWidget with PreferredSizeWidget {
  const AppAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocaleController controller = Get.find();

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        CircleAvatar(
          backgroundColor: kCircleColor,
          child: Image.asset(
            width: 20,
            UserPreferencesController().getLangCode() == 'ar'
                ? 'images/sa.png'
                : 'images/us.png',
          ),
        ),
        SizedBox(width: kDefaultPadding),
        DropdownButton<String>(
          elevation: 1,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(14),
          underline: Container(),
          items: const [
            DropdownMenuItem(
              value: 'en',
              child: Text(
                'English',
                style: TextStyle(fontFamily: 'Stolzl'),
              ),
            ),
            DropdownMenuItem(
              value: 'ar',
              child: Text(
                'العربية',
                style: TextStyle(fontFamily: 'Changa'),
              ),
            ),
          ],
          onChanged: (String? value) {
            controller.changeLang(value!);
          },
          value: UserPreferencesController().getLangCode(),
        ),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
