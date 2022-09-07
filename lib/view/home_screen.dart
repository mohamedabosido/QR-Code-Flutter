import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:flutter_qr/view/result_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_qr/controller/qr_controller.dart';
import 'package:scan/scan.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final ImagePicker _picker = ImagePicker();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  QrController getController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 59,
        child: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: kPrimaryColor,
                borderRadius: 20,
                borderLength: 40,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
            Positioned(
              left: 120,
              right: 120,
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
                            saveQr(result!);
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
                        onTap: () async {
                          await controller!.toggleFlash();
                        },
                        child: SvgPicture.asset(
                          'images/flash.svg',
                          color: kPrimaryColor,
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: SizedBox(
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.stopCamera();
      if (result != null) {
        saveQr(result!.code!);
      }
    });

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void saveQr(String result) {
    QrCodeModel qr = QrCodeModel(
      type: 'Qr Code',
      url: result,
      time: DateTime.now(),
    );
    if (UserPreferencesController().getSound()) {
      FlutterBeep.beep();
    }
    if (UserPreferencesController().getVibrate()) {
      Vibration.vibrate(duration: 2000);
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
    getController.add(qr: qr);
    Get.to(() => ResultScreen(qr: qr));
  }
}
