import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSwitchListTile extends StatefulWidget {
  String icon;
  String title;
  String subTitle;
  bool value;

  AppSwitchListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.value,
  });

  @override
  State<AppSwitchListTile> createState() => _AppSwitchListTileState();
}

class _AppSwitchListTileState extends State<AppSwitchListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: kCircleColor,
        child: SvgPicture.asset(
          widget.icon,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        widget.subTitle,
        style: TextStyle(color: kSecondaryTextColor, fontSize: 12),
      ),
      trailing: Switch(
        activeColor: Colors.white,
        activeTrackColor: kPrimaryColor,
        inactiveTrackColor: kCircleColor,
        value: widget.value,
        onChanged: (value) {
          setState(() {
            widget.value = value;
          });
        },
      ),
    );
  }
}
