import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_auth_controller.dart';
import 'package:flutter_qr/widgets/app_button.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:get/get.dart';
import 'package:flutter_qr/widgets/app_app_bar.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  TextEditingController emailController = TextEditingController();

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
                  'forget-password'.tr,
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
                  'forget-sub'.tr,
                  style: TextStyle(fontSize: 16, color: kSecondaryTextColor),
                ),
              ),
              SizedBox(height: kDefaultPadding * 2),
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
              AppButton(
                onPressed: () async {
                  await resetPassword(email: emailController.text);
                },
                color: kPrimaryColor,
                child: Text(
                  'send'.tr,
                  style: const TextStyle(fontSize: 18),
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

  Future<bool> resetPassword({required email}) async {
    if (checkData()) {
      Get.toNamed('/login_screen');
      return await FbAuthController().resetPassword(email);
    }
    return false;
  }
}
