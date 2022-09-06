import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/view/locale/locale_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LanguageListTile extends StatefulWidget {
  String icon;
  String title;

  LanguageListTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  State<LanguageListTile> createState() => _LanguageListTileState();
}

class _LanguageListTileState extends State<LanguageListTile> {
  MyLocaleController controller = Get.find();
  String codeLang = UserPreferencesController().getLangCode();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: kCircleColor,
        child: SvgPicture.asset(
          widget.icon,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: SizedBox(
        width: 160,
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                controller.changeLang('ar');
                setState(() {
                  codeLang = 'ar';
                });
              },
              style: codeLang == 'ar'
                  ? ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  : ElevatedButton.styleFrom(
                      backgroundColor: kCircleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: kBorderColor),
                      ),
                    ),
              child: Text(
                'العربية',
                style: TextStyle(
                    color:
                        codeLang == 'ar' ? Colors.white : kSecondaryTextColor),
              ),
            ),
            SizedBox(width: kDefaultPadding / 2),
            ElevatedButton(
              style: codeLang == 'en'
                  ? ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  : ElevatedButton.styleFrom(
                      backgroundColor: kCircleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: kBorderColor),
                      ),
                    ),
              onPressed: () {
                controller.changeLang('en');
                setState(() {
                  codeLang = 'en';
                });
              },
              child: Text(
                'English',
                style: TextStyle(
                    color:
                        codeLang == 'en' ? Colors.white : kSecondaryTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
