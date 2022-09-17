import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_fire_store_controller.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:flutter_qr/view/history_result_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'History'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(color: kLineColor),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: FbFireStoreController().read(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<QueryDocumentSnapshot> history = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      int reverseIndex = history.length - 1 - index;
                      QrCodeModel qr = QrCodeModel(
                        url: history[reverseIndex].get('url'),
                        type: history[reverseIndex].get('type'),
                        time: history[reverseIndex].get('time'),
                      );
                      qr.id = history[reverseIndex].get('id');
                      DateTime time =
                          (history[reverseIndex].get('time') as Timestamp)
                              .toDate();
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              autoClose: true,
                              onPressed: (BuildContext context) {
                                FbFireStoreController().delete(qr: qr);
                              },
                              backgroundColor: kCircleColor,
                              foregroundColor: Colors.red,
                              icon: Icons.delete_outline_rounded,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => HistoryResultScreen(qr: qr));
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kCircleColor,
                                  child: Image.asset(
                                    history[reverseIndex]['type'] == 'product'
                                        ? 'images/bar_code.png'
                                        : 'images/qr_code.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                title: Text(
                                  history[reverseIndex]['type'] == 'wifi'
                                      ? '${"wifi".tr}: ${history[reverseIndex]['url'].split(';')[2].split(':')[1]}'
                                      : history[reverseIndex]['url'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                subtitle: Text(
                                  '${qr.type.tr} - ${"scanned".tr} - ${time.day}/${time.month}/${time.year} - ${time.hour}:${time.minute}',
                                  style: TextStyle(
                                      color: kSecondaryTextColor, fontSize: 12),
                                ),
                              ),
                            ),
                            Divider(color: kLineColor),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                maximumSize: const Size(155, 40),
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32))),
            onPressed: () {
              Navigator.pushNamed(context, '/main_screen');
            },
            child: Row(
              children: [
                SvgPicture.asset('images/Scaner.svg', color: Colors.white),
                SizedBox(width: kDefaultPadding / 2),
                Text(
                  'Scan-code'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
