import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_auth_controller.dart';
import 'package:flutter_qr/model/qr_model.dart';
import 'package:get/get.dart';

class FbFireStoreController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //CRUD

  Future<bool> create({required QrCodeModel qr}) async {
    return fireStore
        .collection('users-scannes')
        .doc(FbAuthController().firebaseAuth.currentUser!.uid)
        .collection('qrcodes')
        .add(qr.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> delete({required QrCodeModel qr}) async {
    await fireStore
        .collection('users-scannes')
        .doc(FbAuthController().firebaseAuth.currentUser!.uid)
        .collection('qrcodes')
        .where("id", isEqualTo: qr.id)
        .get()
        .then((QuerySnapshot snapshot) async {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
      Get.snackbar(
        'Deleted Qr Code'.tr,
        qr.type == 'wifi'
            ? '${"wifi".tr}: ${qr.url.split(';')[2].split(':')[1]}'
            : qr.url,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(kDefaultPadding),
      );
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
    return false;
  }

  Stream<QuerySnapshot> read() async* {
    yield* fireStore
        .collection('users-scannes')
        .doc(FbAuthController().firebaseAuth.currentUser!.uid)
        .collection('qrcodes')
        .snapshots();
  }
}
