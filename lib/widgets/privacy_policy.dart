import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/prefs/user_preferences_controller.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.bottomSheet(
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close, color: kSecondaryTextColor),
                ),
                title: Text(
                  'Privacy Policy'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(color: kLineColor),
                    Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ultricies quis sagittis, elit est a scelerisque. Laoreet elementum felis neque eu ac. Lectus dapibus id sapien sit accumsan risus molestie nisl. Duis porttitor dictumst nibh malesuada scelerisque turpis. Quis quis in ultricies aliquam ipsum integer elit eget. Id tellus varius purus tellus semper est ante mollis dignissim. Nulla integer eget diam sem ornare venenatis. Nascetur consectetur ornare tincidunt faucibus varius duis sit eleifend curabitur. Fusce vivamus arcu amet arcu risus facilisi.Posuere faucibus quis vitae fringilla auctor. Vestibulum turpis fermentum mattis condimentum quis. Diam justo, lorem volutpat, parturient natoque dignissim. Massa semper ultrices nibh sodales mauris et lacus. Quam sit nam vel sagittis sed amet ornare consequat adipiscing. Tortor amet, sed nisl urna.Maecenas dui habitant non orci. Donec velit ornare enim, dolor. Eget erat egestas mi proin at. Ipsum Maecenas dui habitant non orci. Donec velit ornare enim, dolor. Eget erat egestas mi proin at. Ipsum viverra nunc vel rhoncus, bibendum congue. At ipsum leo nunc tellus. Ut sit venenatis pharetra, eget adipiscing nibh. Ullamcorper vitae faucibus arcu laoreet tortor. Ultrices arcu et feugiat metus nec posuere vitae commodo. Integer quam pharetra semper nulla sed dis ut integer amet. Sit ac volutpat in enim magna amet maecenas. Turpis elit bibendum faucibus tincidunt. Duis egestas nunc nullam donec.Diam elementum sit feugiat dignissim hend',
                        style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: 16,
                          height: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          isDismissible: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          isScrollControlled: true,
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By clicking'.tr,
          style: TextStyle(
            color: kSecondaryTextColor,
            fontSize: 14,
            fontFamily: UserPreferencesController().getLangCode() == 'en'
                ? 'Stolzl'
                : 'Changa',
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'terms'.tr,
              style: TextStyle(color: kPrimaryColor, fontSize: 14),
            ),
            TextSpan(
              text: 'and'.tr,
              style: TextStyle(
                color: kSecondaryTextColor,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: 'Privacy Policy'.tr,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
