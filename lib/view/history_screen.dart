import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/qr_controller.dart';
import 'package:flutter_qr/view/history_result_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  QrController controller = Get.find();

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
            child: GetBuilder<QrController>(
              init: QrController(),
              builder: (controller) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.history.length,
                  itemBuilder: (context, index) {
                    int reverseIndex = controller.history.length - 1 - index;
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            autoClose: true,
                            onPressed: (BuildContext context) {
                              controller.delete(
                                  qr: controller.history[reverseIndex]);
                            },
                            backgroundColor: kCircleColor,
                            foregroundColor: Colors.red,
                            icon: Icons.delete_outline_rounded,
                            borderRadius: BorderRadius.circular(15),
                            // label: 'Archive',
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => HistoryResultScreen(
                                  qr: controller.history[reverseIndex]));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundColor: kCircleColor,
                                child: Image.asset(
                                  controller.history[reverseIndex].type ==
                                          'product'
                                      ? 'images/bar_code.png'
                                      : 'images/qr_code.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              title: Text(
                                controller.history[reverseIndex].type == 'wifi'
                                    ? '${"wifi".tr}: ${controller.history[reverseIndex].url.split(';')[2].split(':')[1]}'
                                    : controller.history[reverseIndex].url,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              subtitle: Text(
                                '${controller.history[reverseIndex].type.tr} - ${"scanned".tr} - ${controller.history[reverseIndex].time!.day}/${controller.history[reverseIndex].time!.month}/${controller.history[reverseIndex].time!.year} - ${controller.history[reverseIndex].time!.hour}:${controller.history[reverseIndex].time!.minute}',
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
