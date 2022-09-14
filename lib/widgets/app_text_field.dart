import 'package:flutter/material.dart';

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
    return Material(
      shadowColor: Colors.black,
      child: TextField(
        keyboardType: isPassword
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
