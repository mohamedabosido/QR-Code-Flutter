import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_auth_controller.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/widgets/custom_app_list_tile.dart';
import 'package:flutter_qr/widgets/language_list_tile.dart';
import 'package:flutter_qr/widgets/switch_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Settings'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(color: kLineColor),
          AppSwitchListTile(
            icon: 'images/settings_icon.svg',
            title: 'Sound'.tr,
            subTitle: 'Beep when scanned'.tr,
            value: UserPreferencesController().getSound(),
          ),
          AppSwitchListTile(
            icon: 'images/settings_icon.svg',
            title: 'Vibrate'.tr,
            subTitle: 'Vibrate when scanned'.tr,
            value: UserPreferencesController().getVibrate(),
          ),
          AppSwitchListTile(
            icon: 'images/settings_icon.svg',
            title: 'Copy to Clipboard'.tr,
            subTitle: 'Auto-copy scanned QR result'.tr,
            value: UserPreferencesController().getCopyAlways(),
          ),
          SizedBox(height: kDefaultPadding),
          Divider(
            color: kLineColor,
            thickness: 8,
          ),
          SizedBox(height: kDefaultPadding),
          LanguageListTile(
              icon: 'images/language-translate.svg', title: 'Language'.tr),
          SizedBox(height: kDefaultPadding * 1.5),
          CustomAppListTile(
            icon: 'images/user-protection-shield-square.svg',
            title: 'Privacy Policy'.tr,
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: kUnselectedIconColor,
                size: 16,
              ),
            ),
          ),
          SizedBox(height: kDefaultPadding * 1.5),
          CustomAppListTile(
            icon: 'images/logout.svg',
            title: 'logout'.tr,
            trailing: IconButton(
              onPressed: () async {
                await FbAuthController().signOut();
                Get.offAllNamed('/auth_screen');
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: kUnselectedIconColor,
                size: 16,
              ),
            ),
          ),
          SizedBox(height: kDefaultPadding * 1.5),
          Divider(
            color: kLineColor,
            thickness: 8,
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                '${'Version'.tr} 1.00',
                style: TextStyle(
                  color: kUnselectedIconColor,
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse('https://centroware.com/'));
                },
                child: RichText(
                  text: TextSpan(
                    text: 'made'.tr,
                    style: const TextStyle(color: Colors.black),
                    children: const [
                      TextSpan(
                        text: 'centroware',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
            ],
          )
        ],
      ),
    );
  }
}
