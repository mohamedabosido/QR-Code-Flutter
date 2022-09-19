import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';

// ignore: must_be_immutable
class CodeTextField extends StatelessWidget {
  CodeTextField({required this.controller, super.key});

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        width: 50,
        margin: EdgeInsetsDirectional.only(end: kDefaultPadding * 1.5),
        child: TextField(
          textAlignVertical: TextAlignVertical.top,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          maxLength: 1,
          textAlign: TextAlign.center,
          showCursor: false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            counterText: '',
            filled: true,
            fillColor: kCircleColor,
          ),
        ),
      ),
    );
  }
}
