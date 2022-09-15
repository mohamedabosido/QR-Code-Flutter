import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/constant/constants.dart';
import 'package:get/get.dart';

typedef UserAuthStatus = void Function({required bool loggedIn});

class FbAuthController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
            'Verify Email to login into the app',
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
    required String email,
    required String password,
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
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _controlException(e);
    }
    return false;
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
}
