import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_auth_controller.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

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
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: kDefaultPadding * 2,
                    right: kDefaultPadding * 2,
                    top: kDefaultPadding * 9),
                child: Column(
                  children: [
                    SizedBox(
                      width: 104,
                      height: 104,
                      child: SvgPicture.asset('images/logo.svg',
                          color: kPrimaryColor),
                    ),
                    SizedBox(height: kDefaultPadding),
                    SizedBox(height: kDefaultPadding * 2),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'login to your account'.tr,
                        style:
                            const TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 2),
                    AppTextFiled(
                        text: 'email'.tr,
                        isPassword: false,
                        controller: emailController),
                    SizedBox(height: kDefaultPadding),
                    AppTextFiled(
                        text: 'password'.tr,
                        isPassword: true,
                        controller: passwordController),
                    SizedBox(height: kDefaultPadding * 3),
                    ElevatedButton(
                      onPressed: () async {
                        if (await performLogin()) {
                          Get.offAllNamed('/main_screen');
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Text(
                        'signin'.tr,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 2),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'dont have account'.tr,
                            style: TextStyle(
                                color: kSecondaryTextColor, fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/sign_up_screen');
                            },
                            child: Text(
                              'signup'.tr,
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    )
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
