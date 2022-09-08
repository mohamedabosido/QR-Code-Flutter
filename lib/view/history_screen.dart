import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/qr_controller.dart';
import 'package:flutter_qr/view/history_result_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

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
              builder: (controller) => ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: controller.history.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          autoClose: true,
                          onPressed: (BuildContext context) {
                            controller.delete(qr: controller.history[index]);
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
                                qr: controller.history[index]));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundColor: kCircleColor,
                              child: Image.asset(
                                'images/qr_code.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            title: Text(
                              controller.history[index].url,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            subtitle: Text(
                              '${controller.history[index].type} - website - ${controller.history[index].time!.day}/${controller.history[index].time!.month}/${controller.history[index].time!.year} - ${controller.history[index].time!.hour}:${controller.history[index].time!.minute}',
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
              ),
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
