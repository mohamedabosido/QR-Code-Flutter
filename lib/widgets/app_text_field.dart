import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';

class AppTextFiled extends StatelessWidget {
  String text;
  TextEditingController controller;
  bool isPassword;

  AppTextFiled({
    required this.text,
    required this.controller,
    required this.isPassword,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: isPassword
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: kLineColor,
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
