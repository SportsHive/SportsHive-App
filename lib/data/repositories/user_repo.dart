import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportshive/data/controllers/profile_controller.dart';
import 'package:sportshive/data/controllers/sign_up_controllers.dart';
import '../../screens/auth/preference_screen.dart';
import '../models/user_model.dart';
import 'auth_repo.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

    final _db = FirebaseFirestore.instance;
    final authRepo = Get.put(AuthenticationRepository());
    bool isUserCreated = false;

    late UserModel userData = UserModel(email: getUserEmail(), username: "", password: "");

    void initState() async {
      userData = (await getUserData())!;
    }

    Future<UserModel?> getUserData() async {
      final email = authRepo.firebaseUser.value?.email;
      if (email != null) {
        return getUserDetails(email);
      } else {
        Get.snackbar("Error", "Login to continue");
        return null; // Add this line to return null when email is null
      }
    }

    onComplete(user, context) {
      Get.snackbar("Success", "Your SportsHive account has been created successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orangeAccent.withOpacity(1),
          colorText: Colors.black);
          Future.delayed(Duration(seconds: 1), () {
              SignUpController.instance.signUp(user.email, user.password);
             Navigator.push(context, MaterialPageRoute(builder: (context) => SportsPreferenceScreen()));
          });
      
    }


    createUser(UserModel user, context) async { 
      await _db.collection("USER").add(user.toJson()).whenComplete(
        () => onComplete(user, context),
      )
      .catchError((error, stackTrace) {
          Get.snackbar("Error", "Something went wrong! Try again.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(1),
          colorText: Colors.black);
          print(error.toString());
      });
      isUserCreated = true;
    }

    //get specific user info
    Future<UserModel?> getUserDetails(String email) async {
  
      final snapshot = await _db.collection("USER").where("email", isEqualTo: email).get();
      final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
      
    }

  //get all users in the db
  Future<List<UserModel>> getUsers() async {
    final snapshot = await _db.collection("USER").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  //Get the email of the current signed in user
  String getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.displayName!;
      return email;
    }
    return "";
  }

}