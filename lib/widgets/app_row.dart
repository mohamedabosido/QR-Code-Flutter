import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppRow extends StatelessWidget {
  String icon;
  String title;
  VoidCallback onTap;

  AppRow({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: kCircleColor,
            child: SvgPicture.asset(
              icon,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: kDefaultPadding / 2),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
