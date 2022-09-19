import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/view/history_screen.dart';
import 'package:flutter_qr/view/settings_screen.dart';
import 'package:flutter_qr/view/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 16,
        selectedFontSize: 16,
        currentIndex: _currentIndex,
        elevation: 0,
        backgroundColor: _currentIndex == 0 ? Colors.black : Colors.white,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kUnselectedIconColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'images/Scaner.svg',
                color:
                    _currentIndex == 0 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: 'Scan'.tr),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'images/History.svg',
                color:
                    _currentIndex == 1 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: 'History'.tr),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'images/settings.svg',
                color:
                    _currentIndex == 2 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: 'Settings'.tr),
        ],
      ),
    );
  }
}
