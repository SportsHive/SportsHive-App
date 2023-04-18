

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final  text_email = TextEditingController();
  final text_pass = TextEditingController();
  final  text_check = TextEditingController();
  final  text_bio = TextEditingController();
  final  text_username = TextEditingController();

  @override
  //function to sign Up users
  void signUp(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
}