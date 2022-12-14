import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_auth_controller.dart';
import 'package:flutter_qr/widgets/app_app_bar.dart';
import 'package:flutter_qr/widgets/app_button.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
                        'signin'.tr,
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
                        'signin-sub'.tr,
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
                        text: 'enter-email'.tr,
                        isPassword: false,
                        controller: emailController),
                    SizedBox(height: kDefaultPadding * 1.5),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'password'.tr,
                        style:
                            TextStyle(fontSize: 14, color: kSecondaryTextColor),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    AppTextFiled(
                        text: 'enter-password'.tr,
                        isPassword: true,
                        controller: passwordController),
                    SizedBox(height: kDefaultPadding),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('/forget_password_screen');
                        },
                        child: Text(
                          'forget-password'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),
                    AppButton(
                      onPressed: () async {
                        if (await performLogin()) {
                          Get.offAllNamed('/main_screen');
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      color: kPrimaryColor,
                      child: Text(
                        'signin'.tr,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<bool> performLogin() async {
    if (checkData()) {
      return await login();
    }
    return false;
  }

  bool checkData() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
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

  Future<bool> login() async {
    bool status = await FbAuthController().signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    return status;
  }
}
