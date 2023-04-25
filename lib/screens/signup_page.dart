import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportshive/components/background.dart';
import 'package:sportshive/components/rounded_button.dart';
import 'package:sportshive/data/controllers/sign_up_controllers.dart';
import 'package:sportshive/data/models/user_model.dart';
import 'package:sportshive/responsive/mobile_screen_layout.dart';
import 'package:sportshive/screens/preference_screen.dart';
import 'package:sportshive/screens/welcome_screen.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:sportshive/widgets/text_field_input.dart' as CustomTextField;
import 'package:sportshive/screens/editprofile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:sportshive/data/controllers/sign_up_controllers.dart';

import '../../data/repositories/user_repo.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger the Google Authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      // Obtain the authentication details from the Google user
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in the user with the credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return null;
  } catch (e) {
    print(e);
    return null;
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignupScreen> {
  final controller = Get.put(SignUpController());
  final userRepo = Get.put(UserRepository());

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formkey,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: orange,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      body: Background(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //svg image
              Image.asset(
                'assets/original_logo.png',
                height: 140,
              ),

              const SizedBox(height: 10),

              //textfield for username
              CustomTextField.TextFieldInput(
                textEditingController: controller.text_username,
                hintText: 'Create a username',
                textInputType: TextInputType.text,
                prefixIcon: Icons.person,
                borderColor: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: 15,
                borderWidth: 2.0,
              ),
              const SizedBox(height: 24),

              //textfield for email
              CustomTextField.TextFieldInput(
                textEditingController: controller.text_email,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                borderColor: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: 15,
                borderWidth: 2.0,
              ),

              const SizedBox(height: 24),

              //textfield for password
              CustomTextField.TextFieldInput(
                textEditingController: controller.text_pass,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
                prefixIcon: Icons.lock,
                borderColor: Colors.black,
                borderRadius: 15,
                borderWidth: 2.0,
              ),

              const SizedBox(height: 24),
              //textfield for confirmation password
              CustomTextField.TextFieldInput(
                textEditingController: controller.text_check,
                hintText: 'Confirm your password',
                textInputType: TextInputType.text,
                isPass: true,
                prefixIcon: Icons.lock,
                borderColor: Colors.black,
                borderRadius: 15,
                borderWidth: 2.0,
              ),

              //button for Register
              const SizedBox(height: 24),
              InkWell(
                child: RoundedButton(
                  text: 'Register Now!',
                  press: () {
                    if (canPass()) {
                      if (_formkey.currentState == null) {
                      } else if (_formkey.currentState!.validate()) {
                        final user = UserModel(
                            email: controller.text_email.text.trim(),
                            username: controller.text_username.text.trim(),
                            password: controller.text_pass.text.trim(),
                            followers: 0,
                            following: 0);

                        SignUpController.instance.createUser(user, context);
                      }
                    }
                  },
                ),
              ),

              const SizedBox(height: 1),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //Transition to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: signInWithGoogle,
                    child: Image.asset(
                      'assets/google-logo.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    width:
                        20, // Adjust this value to increase or decrease the spacing between the logos
                  ),
                  InkWell(
                    onTap: signInWithGoogle,
                    child: Image.asset(
                      'assets/apple-logo.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool canPass() {
    if (controller.text_username.text.isEmpty) {
      Get.snackbar("Error", "Please enter a valid username",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black.withOpacity(1),
          colorText: orange);
      print("Please enter a valid username.");
      return false;
    } else if (controller.text_pass.text.trim() == "") {
      Get.snackbar("Error", "Password field is empty",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black.withOpacity(1),
          colorText: orange);
      print("Password is empty!");
      return false;
    } else if (controller.text_pass.text.trim() !=
        controller.text_check.text.trim()) {
      Get.snackbar("Error",
          "Password and Verify Password fields does not have the same value",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black.withOpacity(1),
          colorText: orange);
      print("Password is not verified!");
      return false;
    } else if (controller.text_email.text.isEmpty) {
      Get.snackbar("Error", "Please enter a valid email",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black.withOpacity(1),
          colorText: orange);
      print("Please enter a valid email.");
      return false;
    } else if (controller.text_pass.text.trim().length < 8) {
      Get.snackbar(
          "Error", "Please enter at least 8 characters for the password",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black.withOpacity(1),
          colorText: orange);
      print("short password");
      return false;
    }
    return true;
  }
}
