import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/widgets/custom_app_list_tile.dart';
import 'package:flutter_qr/widgets/language_list_tile.dart';
import 'package:flutter_qr/widgets/switch_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: const Text(
          'Settings',
          style: TextStyle(
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
            title: 'Sound',
            subTitle: 'Beep when scanned',
            value: true,
          ),
          AppSwitchListTile(
            icon: 'images/settings_icon.svg',
            title: 'Vibrate',
            subTitle: 'Vibrate when scanned',
            value: false,
          ),
          AppSwitchListTile(
            icon: 'images/settings_icon.svg',
            title: 'Copy to clipboard',
            subTitle: 'Auto-copy scanned QR result',
            value: false,
          ),
          SizedBox(height: kDefaultPadding),
          Divider(
            color: kLineColor,
            thickness: 8,
          ),
          SizedBox(height: kDefaultPadding),
          LanguageListTile(icon: 'images/language-translate.svg', title: 'Language'),
          SizedBox(height: kDefaultPadding * 1.5),
          CustomAppListTile(
            icon: 'images/user-protection-shield-square.svg',
            title: 'Privacy Policy',
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
          Divider(
            color: kLineColor,
            thickness: 8,
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                'Version 1.00',
                style: TextStyle(
                  color: kUnselectedIconColor,
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              TextButton(
                onPressed: () async{
                  await launchUrl(Uri.parse('https://centroware.com/'));
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'made with',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: ' ❤️ by centroware',
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
