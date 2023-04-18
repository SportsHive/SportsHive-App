import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserRepository extends GetxController {
    static UserRepository get instance => Get.find();

    final _db = FirebaseFirestore.instance;

    createUser(UserModel user) async {
      await _db.collection("USER").add(user.toJson()).whenComplete(
        () => Get.snackbar("Success", "Your SportsHive account has been created successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),
      )
      .catchError((error, stackTrace) {
          Get.snackbar("Error", "Something went wrong! Try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
          print(error.toString());
      });
    }
}