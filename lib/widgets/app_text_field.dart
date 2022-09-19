import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class AppTextFiled extends StatefulWidget {
  String text;
  TextEditingController controller;
  bool isPassword;
  bool isMobile;
  TextInputType textInputType;

  AppTextFiled({
    required this.text,
    required this.controller,
    this.isPassword = false,
    this.isMobile = false,
    this.textInputType = TextInputType.emailAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<AppTextFiled> createState() => _AppTextFiledState();
}

class _AppTextFiledState extends State<AppTextFiled> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        maxLength: widget.isMobile ? 7 : 30,
        keyboardType: widget.isPassword
            ? TextInputType.visiblePassword
            : widget.textInputType,
        controller: widget.controller,
        obscureText: showPassword,
        decoration: InputDecoration(
          counterText: '',
          suffix: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: showPassword
                      ? SvgPicture.asset('images/eye.svg', width: 22)
                      : SvgPicture.asset('images/eye.svg',
                          color: kPrimaryColor, width: 22),
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: widget.isMobile
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: kDefaultPadding / 2),
                    Image.asset('images/ps.png'),
                    SizedBox(width: kDefaultPadding / 2),
                    const Text('970'),
                    SizedBox(width: kDefaultPadding / 2)
                  ],
                )
              : null,
          hintStyle: TextStyle(color: kSecondaryTextColor, fontSize: 14),
          filled: true,
          fillColor: kCircleColor,
          hintText: widget.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
