import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;

  const AppButton({
    required this.child,
    required this.onPressed,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: color == Colors.white
              ? BorderSide(color: kBorderColor)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: child,
    );
  }
}
