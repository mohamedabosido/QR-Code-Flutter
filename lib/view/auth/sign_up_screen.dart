import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_auth_controller.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

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
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: kDefaultPadding * 2,
                    right: kDefaultPadding * 2,
                    top: kDefaultPadding),
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
                        'create a new account'.tr,
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
                    SizedBox(height: kDefaultPadding),
                    AppTextFiled(
                        text: 'confirm-password'.tr,
                        isPassword: true,
                        controller: confirmPasswordController),
                    SizedBox(height: kDefaultPadding * 3),
                    ElevatedButton(
                      onPressed: () async {
                        if (await performRegister()) {
                          Get.offAllNamed('/login_screen');
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
                        'signup'.tr,
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
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text) {
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
    );
    return status;
  }
}
