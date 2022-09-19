import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/widgets/app_app_bar.dart';
import 'package:flutter_qr/widgets/app_button.dart';
import 'package:flutter_qr/widgets/privacy_policy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child:
                    SvgPicture.asset('images/logo.svg', color: kPrimaryColor),
              ),
              SizedBox(height: kDefaultPadding),
              const Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'QR Code \nScanner',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Stolzl',
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'A dynamic QR solution',
                  style: TextStyle(
                    fontSize: 16,
                    color: kSecondaryTextColor,
                    fontFamily: 'Stolzl',
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding * 5),
              AppButton(
                onPressed: () {},
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('images/apple.svg'),
                    SizedBox(width: kDefaultPadding / 2),
                    Text('apple'.tr)
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              AppButton(
                onPressed: () {},
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('images/google.svg'),
                    SizedBox(width: kDefaultPadding / 2),
                    Text(
                      'google'.tr,
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              AppButton(
                onPressed: () {
                  Get.toNamed('/login_screen');
                },
                color: kPrimaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('images/email.svg'),
                    SizedBox(width: kDefaultPadding / 2),
                    Text(
                      'email-sign'.tr,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'dont have account'.tr,
                      style:
                          TextStyle(color: kSecondaryTextColor, fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/sign_up_screen');
                      },
                      child: Text(
                        'signup'.tr,
                        style: TextStyle(color: kPrimaryColor, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              Divider(color: kLineColor),
              SizedBox(height: kDefaultPadding * 1.5),
              const PrivacyPolicy(),
            ],
          ),
        ),
      ),
    );
  }
}
