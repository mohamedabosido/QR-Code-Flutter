import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppListTile extends StatelessWidget {
  String icon;
  String title;
  String subTitle;
  VoidCallback onPressed;

  AppListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: kCircleColor,
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(color: kSecondaryTextColor, fontSize: 12),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_forward_ios_outlined,
          color: kUnselectedIconColor,
          size: 16,
        ),
      ),
    );
  }
}
