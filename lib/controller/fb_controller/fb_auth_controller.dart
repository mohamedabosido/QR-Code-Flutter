import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:flutter_qr/controller/fb_controller/fb_fire_store_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef UserAuthStatus = void Function({required bool loggedIn});

class FbAuthController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          return true;
        } else {
          await signOut();
          Get.snackbar(
            'Verify Email to login into the app'.tr,
            '',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(kDefaultPadding),
          );
          return false;
        }
      }
    } on FirebaseAuthException catch (e) {
      _controlException(e);
    }
    return false;
  }

  Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
    required String mobile,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        userCredential.user?.sendEmailVerification();
        Get.snackbar(
          'Check Your Email to Verify your Account'.tr,
          '',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(kDefaultPadding),
        );
        FbFireStoreController()
            .fireStore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'mobile': '+970$mobile',
        });
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _controlException(e);
    }
    return false;
  }

  Future<bool> loginWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);
      Get.offAllNamed('/main_screen');
      return true;
    }
    return false;
  }

  Future<bool> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Check your email to reset password',
        '',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(kDefaultPadding),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        e.message.toString(),
        '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(kDefaultPadding),
      );
      return false;
    }
  }

  Future<void> signOut() async {
    firebaseAuth.signOut();
  }

  bool loggedIn() => firebaseAuth.currentUser != null;

  StreamSubscription<User?> checkUserStatus(UserAuthStatus userAuthStatus) {
    return firebaseAuth.authStateChanges().listen((event) {
      userAuthStatus(loggedIn: event != null);
    });
  }

  void _controlException(FirebaseAuthException exception) {
    String error = 'error';
    switch (exception.code) {
      case 'invalid-email':
        error = 'invalid-email'.tr;
        break;
      case 'user-disabled':
        error = 'user-disabled'.tr;
        break;
      case 'user-no-found':
        error = 'user-no-found'.tr;
        break;
      case 'wrong-password':
        error = 'wrong-password'.tr;
        break;
    }
    Get.snackbar(
      error,
      '',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(kDefaultPadding),
    );
  }

  void signInWithPhoneNumber({required code, required verificationId}) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      final User? user =
          (await firebaseAuth.signInWithCredential(credential)).user;

      Get.snackbar("Successfully signed in UID:", ' ${user?.uid}');
      Get.offAllNamed('/main_screen');
    } catch (e) {
      Get.snackbar("Failed to sign in: ", e.toString());
    }
  }

  void verifyPhoneNumber({required mobile, required vId}) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobile,
          timeout: const Duration(seconds: 60),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await firebaseAuth.signInWithCredential(phoneAuthCredential);
            Get.snackbar(
                "Phone number automatically verified and user signed in:",
                ' ${firebaseAuth.currentUser!.uid}');
          },
          verificationFailed: (FirebaseAuthException authException) {
            Get.snackbar(
                'Phone number verification failed. Code: ${authException.code}.',
                ' Message: ${authException.message}');
          },
          codeSent: (String verificationId, [int? forceResendingToken]) async {
            Get.snackbar(
                'Please check your phone for the verification code.', '');
            vId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            Get.snackbar("verification code: $verificationId", '');
            vId = verificationId;
          });
    } catch (e) {
      Get.snackbar("Failed to Verify Phone Number:", ' $e');
    }
  }
}
