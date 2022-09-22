import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_auth_controller.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/widgets/app_app_bar.dart';
import 'package:flutter_qr/widgets/app_button.dart';
import 'package:flutter_qr/widgets/code_text_field.dart';
import 'package:get/get.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController firstCodeController = TextEditingController();
  FocusNode firstFocusNode = FocusNode();
  TextEditingController secondCodeController = TextEditingController();
  FocusNode secondFocusNode = FocusNode();
  TextEditingController thirdCodeController = TextEditingController();
  FocusNode thirdFocusNode = FocusNode();
  TextEditingController forthCodeController = TextEditingController();
  FocusNode forthFocusNode = FocusNode();
  TextEditingController fifthCodeController = TextEditingController();
  FocusNode fifthFocusNode = FocusNode();
  TextEditingController sixthCodeController = TextEditingController();
  FocusNode sixthFocusNode = FocusNode();

  String verificationId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: kDefaultPadding * 2,
              right: kDefaultPadding * 2,
              top: kDefaultPadding * 2),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'enter-code'.tr,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  '+970 599487724',
                  style: TextStyle(fontSize: 20, color: kPrimaryColor),
                ),
              ),
              SizedBox(height: kDefaultPadding * 2),
              Align(
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CodeTextField(
                      controller: firstCodeController,
                      focusNode: firstFocusNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          secondFocusNode.requestFocus();
                        }
                      },
                    ),
                    CodeTextField(
                      controller: secondCodeController,
                      focusNode: secondFocusNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          thirdFocusNode.requestFocus();
                        } else {
                          firstFocusNode.requestFocus();
                        }
                      },
                    ),
                    CodeTextField(
                      controller: thirdCodeController,
                      focusNode: thirdFocusNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          forthFocusNode.requestFocus();
                        } else {
                          secondFocusNode.requestFocus();
                        }
                      },
                    ),
                    CodeTextField(
                      controller: forthCodeController,
                      focusNode: forthFocusNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          fifthFocusNode.requestFocus();
                        } else {
                          thirdFocusNode.requestFocus();
                        }
                      },
                    ),
                    CodeTextField(
                      controller: fifthCodeController,
                      focusNode: fifthFocusNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          sixthFocusNode.requestFocus();
                        } else {
                          forthFocusNode.requestFocus();
                        }
                      },
                    ),
                    CodeTextField(
                      controller: sixthCodeController,
                      focusNode: sixthFocusNode,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          fifthFocusNode.requestFocus();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              AppButton(
                onPressed: () async {
                  FbAuthController().signInWithPhoneNumber(
                      code: fetchCode(), verificationId: verificationId);
                },
                color: kPrimaryColor,
                child: Text(
                  'verify'.tr,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'resend'.tr,
                  style: TextStyle(
                    color: kSecondaryTextColor,
                    fontSize: 16,
                    fontFamily:
                        UserPreferencesController().getLangCode() == 'en'
                            ? 'Stolzl'
                            : 'Changa',
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '00:52',
                      style: TextStyle(color: kPrimaryColor, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkData() {
    if (firstCodeController.text.isNotEmpty &&
        secondCodeController.text.isNotEmpty &&
        thirdCodeController.text.isNotEmpty &&
        forthCodeController.text.isNotEmpty &&
        fifthCodeController.text.isNotEmpty &&
        sixthCodeController.text.isNotEmpty) {
      return true;
    }
    Get.snackbar(
      'Please Enter All Required Data'.tr,
      '',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(kDefaultPadding),
    );
    return false;
  }

  String fetchCode() {
    if (checkData()) {
      return firstCodeController.text +
          secondCodeController.text +
          thirdCodeController.text +
          forthCodeController.text +
          fifthCodeController.text +
          sixthCodeController.text;
    }
    return '';
  }
}
