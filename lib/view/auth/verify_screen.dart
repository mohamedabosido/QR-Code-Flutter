import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/widgets/app_app_bar.dart';
import 'package:flutter_qr/widgets/app_button.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:flutter_qr/widgets/code_text_field.dart';
import 'package:get/get.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController emailController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : Scaffold(
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
                          CodeTextField(controller: emailController),
                          CodeTextField(controller: emailController),
                          CodeTextField(controller: emailController),
                          CodeTextField(controller: emailController),
                          CodeTextField(controller: emailController),
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),
                    AppButton(
                      onPressed: () async {
                        if (1 == 1) {
                          Get.offAllNamed('/main_screen');
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
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
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 16),
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
    if (emailController.text.isNotEmpty) {
      setState(() {
        loading = true;
      });
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
}
