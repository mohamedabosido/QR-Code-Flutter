import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_fire_store_controller.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/view/result_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan/scan.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  late MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 59,
        child: Stack(
          children: [
            MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) {
                try {
                  if (barcode.rawValue != null) {
                    cameraController.stop();
                    saveQr(result: barcode.rawValue!, type: barcode.type.name);
                    return;
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
            Positioned(
              left: 150,
              right: 150,
              bottom: kDefaultPadding,
              child: Container(
                margin: EdgeInsets.all(kDefaultPadding),
                padding: EdgeInsets.all(kDefaultPadding),
                width: 130,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () async {
                          await _picker
                              .pickImage(source: ImageSource.gallery)
                              .then((value) async {
                            String? result = await Scan.parse(value!.path);
                            saveQr(result: result!);
                            // ignore: invalid_return_type_for_catch_error
                          }).catchError((onError) => {
                                    Get.snackbar(
                                      backgroundColor: Colors.red,
                                      'Please Choose a valid Photo'.tr,
                                      'Just Qr Code'.tr,
                                      colorText: Colors.white,
                                    )
                                  });
                        },
                        child: SvgPicture.asset('images/image-picture.svg')),
                    InkWell(
                        onTap: () {
                          cameraController.toggleTorch();
                          setState(() {});
                        },
                        child: ValueListenableBuilder(
                          valueListenable: cameraController.torchState,
                          builder: (context, state, child) {
                            switch (state) {
                              case TorchState.off:
                                return SvgPicture.asset(
                                  'images/flash.svg',
                                  color: Colors.red,
                                );
                              case TorchState.on:
                                return SvgPicture.asset(
                                  'images/flash.svg',
                                  color: kPrimaryColor,
                                );
                            }
                          },
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(0.4),
                      width: 10,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 250,
                  height: 250,
                  child: Lottie.asset(
                    'images/scan.json',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> shortenUrl({required String url}) async {
    try {
      var uri = Uri.parse('https://cleanuri.com/api/v1/shorten');
      final result = await http.post(uri, body: {
        'url': url,
      });
      if (result.statusCode == 200) {
        final jsonResult = jsonDecode(result.body);
        return jsonResult['result_url'];
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  void saveQr({required String result, type = 'url'}) async {
    final shortenLink = await shortenUrl(url: result);
    QrCodeModel qr =
        QrCodeModel(url: shortenLink!, type: type, time: Timestamp.now());
    qr.id = const Uuid().v4();
    Get.to(() => ResultScreen(qr: qr));
    if (UserPreferencesController().getSound()) {
      FlutterBeep.beep();
    }
    if (UserPreferencesController().getVibrate()) {
      Vibration.vibrate(duration: 1000);
    }
    if (UserPreferencesController().getCopyAlways()) {
      Clipboard.setData(ClipboardData(text: qr.url));
      Get.snackbar(
        'Copy to Clipboard'.tr,
        qr.url,
        backgroundColor: kPrimaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(kDefaultPadding),
      );
    }
    FbFireStoreController().create(qr: qr);
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
