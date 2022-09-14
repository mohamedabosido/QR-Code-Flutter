import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child:
                    SvgPicture.asset('images/logo.svg', color: kPrimaryColor),
              ),
              SizedBox(height: kDefaultPadding),
              SizedBox(height: kDefaultPadding * 2),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Login to your Account',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              SizedBox(height: kDefaultPadding * 2),
              AppTextFiled(
                  text: 'Email',
                  isPassword: false,
                  controller: emailController),
              SizedBox(height: kDefaultPadding),
              AppTextFiled(
                  text: 'Password',
                  isPassword: true,
                  controller: passwordController),
              SizedBox(height: kDefaultPadding * 3),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: kDefaultPadding * 2),
              Align(
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style:
                          TextStyle(color: kSecondaryTextColor, fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/sign_up_screen');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: kPrimaryColor, fontSize: 14),
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
}
