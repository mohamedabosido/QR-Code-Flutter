import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_auth_controller.dart';
import 'package:flutter_qr/widgets/app_app_bar.dart';
import 'package:flutter_qr/widgets/app_button.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:flutter_qr/widgets/privacy_policy.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController mobileController = TextEditingController();
  String vId = '';
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
                  'signup'.tr,
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
                  'signup-sub'.tr,
                  style: TextStyle(fontSize: 16, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding * 2),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Full name'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                text: 'enter-name'.tr,
                controller: nameController,
                textInputType: TextInputType.name,
              ),
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
                  'password'.tr,
                  style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              AppTextFiled(
                  text: 'enter-password'.tr,
                  isPassword: true,
                  controller: passwordController),
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
                text: '599487724',
                controller: mobileController,
                textInputType: TextInputType.number,
                isMobile: true,
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              AppButton(
                onPressed: () async {
                  if (await performRegister()) {
                    FbAuthController().verifyPhoneNumber(
                        mobile: '+970${mobileController.text}', vId: vId);
                    Get.toNamed('/lgoin_screen', arguments: vId);
                  }
                },
                color: kPrimaryColor,
                child: Text(
                  'signup'.tr,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              Align(
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'already have account'.tr,
                      style:
                          TextStyle(color: kSecondaryTextColor, fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/login_screen');
                      },
                      child: Text(
                        'signin'.tr,
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

  bool checkData() {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        mobileController.text.isNotEmpty) {
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

  Future<bool> performRegister() async {
    if (checkData()) {
      return await register();
    }
    return false;
  }

  Future<bool> register() async {
    bool status = await FbAuthController().createAccount(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      mobile: mobileController.text,
    );
    return status;
  }
}
