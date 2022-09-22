import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_fire_store_controller.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/view/result_screen.dart';
import 'package:flutter_qr/widgets/app_app_bar.dart';
import 'package:flutter_qr/widgets/app_button.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

// ignore: must_be_immutable
class VCardScreen extends StatelessWidget {
  VCardScreen({super.key});

  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lastNamecontroller = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController contryController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(title: 'vcard'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'fname'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-fname'.tr,
                  controller: firstNamecontroller,
                  textInputType: TextInputType.name),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'lname'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-lname'.tr,
                  controller: lastNamecontroller,
                  textInputType: TextInputType.name),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'company'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-company'.tr,
                  controller: companyController,
                  textInputType: TextInputType.text),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'designation'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-designation'.tr,
                  controller: designationController,
                  textInputType: TextInputType.text),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'email'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(text: 'enter-email'.tr, controller: emailController),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'home'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: '82623484',
                  controller: homeController,
                  isMobile: true,
                  textInputType: TextInputType.phone),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'work'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: '599416210',
                  controller: workController,
                  isMobile: true,
                  textInputType: TextInputType.phone),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'mobile'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: '597809495',
                  controller: mobileController,
                  isMobile: true,
                  textInputType: TextInputType.phone),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'state'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-state'.tr,
                  controller: stateController,
                  textInputType: TextInputType.text),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'country'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-country'.tr,
                  controller: contryController,
                  textInputType: TextInputType.text),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'address1'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-address1'.tr,
                  controller: address1Controller,
                  textInputType: TextInputType.streetAddress),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'address2'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-address2'.tr,
                  controller: address2Controller,
                  textInputType: TextInputType.streetAddress),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Website'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-website'.tr,
                  controller: websiteController,
                  textInputType: TextInputType.url),
              SizedBox(height: kDefaultPadding * 1.5),
              AppButton(
                onPressed: () async {
                  await vCard();
                },
                color: kPrimaryColor,
                child: Text('send'.tr),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future vCard() async {
    Map body = {
      "name": "vCard Plus QR Code",
      "organization": 186402,
      "qr_type": 2,
      "campaign": {
        "content_type": 7,
        "vcard_plus": {
          "first_name": firstNamecontroller.text,
          "last_name": lastNamecontroller.text,
          "company": companyController.text,
          "designation": designationController.text,
          "email": emailController.text,
          "phone": {
            "home": homeController.text,
            "work": workController.text,
            "mobile": mobileController.text
          },
          "state": stateController.text,
          "country": contryController.text,
          "address_url":
              "https://www.google.com/maps/search/?api=1&query=12.9818683,77.6404922&query_place_id=ChIJt-8HuakWrjsRUNukdoGH8Es",
          "address_line1": address1Controller.text,
          "address_line2": address2Controller.text,
          "summary": "Add me to your contacts to stay in touch",
          "website": websiteController.text,
          "logo_url":
              "https://d1bqobzsowu5wu.cloudfront.net/15406/7c568544870d4d099e39aedf03b64f9e",
          "customizations": {
            "user_info_color": "#160505",
            "background_color": "#eef0f3"
          },
          "user_image_url":
              "https://d1bqobzsowu5wu.cloudfront.net/15406/07c0221877454b3199f5c7c6ff804b2a"
        }
      },
      "location_enabled": false,
      "attributes": {
        "color": "#000000",
        "margin": 80,
        "isVCard": false,
        "colorDark": "#d02525",
        "frameText": "KNOW ME",
        "logoImage":
            "https://d1bqobzsowu5wu.cloudfront.net/15406/8f692e51e7994c5b9b0de8e33767fb5b",
        "logoScale": 0.1992,
        "colorLight": "#ffffff",
        "frameColor": "#000000",
        "frameStyle": "banner-bottom",
        "logoMargin": 10,
        "dataPattern": "square",
        "eyeBallColor": "",
        "eyeBallShape": "circle",
        "gradientType": "none",
        "eyeFrameColor": "#d53232",
        "eyeFrameShape": "rounded",
        "backgroundColor": "#e3ca87",
        "backgroundImage": ""
      }
    };
    var url = Uri.parse('https://api.beaconstac.com/api/2.0/qrcodes/');
    var response = await http.post(url,
        headers: {
          'Authorization': 'Token f4113ea5eb46fde596014ceccb1b69769d4a334d',
          "content-type": "application/json",
        },
        body: jsonEncode(body));
    if (response.statusCode == 201) {
      final jsonResult = jsonDecode(response.body);
      saveQr(result: jsonResult['url']);
    } else {
      Get.snackbar(response.body, '');
    }
  }

  Future<String?> shortenUrl({required String url}) async {
    try {
      var uri = Uri.parse('https://cleanuri.com/api/v1/shorten');
      final result = await http.post(uri, body: {
        'url': url,
      });
      if (result.statusCode == 200) {
        final jsonResult = jsonDecode(result.body);
        return jsonResult['result_url'];
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  void saveQr({required String result, type = 'url'}) async {
    final shortenLink = await shortenUrl(url: result);
    QrCodeModel qr =
        QrCodeModel(url: shortenLink!, type: type, time: Timestamp.now());
    qr.id = const Uuid().v4();
    Get.offAll(() => ResultScreen(qr: qr));
    if (UserPreferencesController().getSound()) {
      FlutterBeep.beep();
    }
    if (UserPreferencesController().getVibrate()) {
      Vibration.vibrate(duration: 1000);
    }
    if (UserPreferencesController().getCopyAlways()) {
      Clipboard.setData(ClipboardData(text: qr.url));
      Get.snackbar(
        'Copy to Clipboard'.tr,
        qr.url,
        backgroundColor: kPrimaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(kDefaultPadding),
      );
    }
    FbFireStoreController().create(qr: qr);
  }
}
