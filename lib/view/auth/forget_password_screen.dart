import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/widgets/app_button.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:get/get.dart';
import 'package:flutter_qr/widgets/app_app_bar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
                        style:
                            TextStyle(fontSize: 16, color: kSecondaryTextColor),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 2),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'email'.tr,
                        style:
                            TextStyle(fontSize: 14, color: kSecondaryTextColor),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    AppTextFiled(
                        text: 'enter-email'.tr, controller: emailController),
                    SizedBox(height: kDefaultPadding * 1.5),
                    AppButton(
                      onPressed: () async {
                        if (1 == 1) {
                          Get.toNamed('/verify_screen');
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
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
