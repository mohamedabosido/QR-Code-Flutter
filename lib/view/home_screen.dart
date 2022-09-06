import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:flutter_qr/view/result_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_qr/controller/qr_controller.dart';
import 'package:scan/scan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String firstButtonText = 'Take photo';
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
      body: Column(
        children: <Widget>[
          SizedBox(
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
                                QrCodeModel qr = QrCodeModel(
                                  type: 'Qr Code',
                                  url: result!,
                                  time: DateTime.now(),
                                );
                                getController.add(qr: qr);
                                Get.to(() => ResultScreen(qr: qr));
                              });
                            },
                            child:
                                SvgPicture.asset('images/image-picture.svg')),
                        InkWell(
                            onTap: () async {
                              await controller!.toggleFlash();
                            },
                            child: SvgPicture.asset('images/flash.svg'))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        QrCodeModel qr = QrCodeModel(
          type: 'Qr Code',
          url: result!.code!,
          time: DateTime.now(),
        );
        QrController().add(qr: qr);
        Get.to(() => ResultScreen(qr: qr));
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
