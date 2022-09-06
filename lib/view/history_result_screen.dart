import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:flutter_qr/widgets/app_row.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryResultScreen extends StatelessWidget {
  QrCodeModel qr;

  HistoryResultScreen({required this.qr, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: kIconColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FlutterShare.share(
                    title: 'Share the Qr',
                    linkUrl: qr.url,
                    chooserTitle: 'Example Chooser Title');
              },
              icon: SvgPicture.asset('images/share.svg'))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: kLineColor),
          Center(
            child: QrImage(
              data: qr.url,
              version: QrVersions.auto,
              size: 160.0,
              backgroundColor: kCircleColor,
            ),
          ),
          SizedBox(height: kDefaultPadding * 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Website',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),
                TextButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(qr.url));
                  },
                  child: Text(
                    qr.url,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),
                Text(
                  'QR code scanned ${qr.time!.day}/${qr.time!.month}/${qr.time!.year} - ${qr.time!.hour}:${qr.time!.minute}',
                  style: TextStyle(
                    color: kSecondaryTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding * 1.5),
          Divider(
            color: kLineColor,
            thickness: 8,
          ),
          SizedBox(height: kDefaultPadding * 1.5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                AppRow(
                  icon: 'images/safari.svg',
                  title: 'Open website',
                  onTap: () async {
                    await launchUrl(Uri.parse(qr.url));
                  },
                ),
                SizedBox(height: kDefaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AppRow(
                          icon: 'images/earth-astronomy.svg',
                          title: 'Copy website',
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: qr.url));
                            Get.snackbar(
                              'Copy to Clipboard',
                              qr.url,
                              backgroundColor: kPrimaryColor,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: EdgeInsets.all(kDefaultPadding),
                            );
                          },
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: qr.url));
                        Get.snackbar(
                          'Copy to Clipboard',
                          qr.url,
                          backgroundColor: kPrimaryColor,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: EdgeInsets.all(kDefaultPadding),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: kCircleColor,
                        child: SvgPicture.asset(
                          'images/copy-paste-select-add-plus.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                AppRow(
                  icon: 'images/share.svg',
                  title: 'Share',
                  onTap: () async {
                    await FlutterShare.share(
                        title: 'Share the Qr',
                        linkUrl: qr.url,
                        chooserTitle: 'Example Chooser Title');
                  },
                )
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding * 1.5),
          Divider(
            color: kLineColor,
            thickness: 8,
          ),
        ],
      ),
    );
  }
}
