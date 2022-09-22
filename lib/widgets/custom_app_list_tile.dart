import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class CustomAppListTile extends StatelessWidget {
  String icon;
  String title;
  VoidCallback onTap;

  CustomAppListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          backgroundColor: kCircleColor,
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.contain,
            width: 32,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: kUnselectedIconColor,
          size: 16,
        ),
      ),
    );
  }
}
