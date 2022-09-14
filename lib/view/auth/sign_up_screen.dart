import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/widgets/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child:
                    SvgPicture.asset('images/logo.svg', color: kPrimaryColor),
              ),
              SizedBox(height: kDefaultPadding),
              SizedBox(height: kDefaultPadding * 2),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Create A New Account',
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
              SizedBox(height: kDefaultPadding),
              AppTextFiled(
                  text: 'Confirm Password',
                  isPassword: true,
                  controller: confirmPasswordController),
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
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
