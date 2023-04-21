import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportshive/componnets/background.dart';
import 'package:sportshive/componnets/rounded_button.dart';
import 'package:sportshive/data/controllers/sign_up_controllers.dart';
import 'package:sportshive/data/models/user_model.dart';
import 'package:sportshive/responsive/mobile_screen_layout.dart';
import 'package:sportshive/screens/auth/preference_screen.dart';
import 'package:sportshive/screens/auth/welcome_screen.dart';
import 'package:sportshive/widgets/text_field_input.dart' as CustomTextField;
import 'package:sportshive/screens/auth/editprofile_page.dart';
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

//trying
  // Future addUserDetails(String email, String password, String username) async {
  //   await FirebaseFirestore.instance.collection('USER').add({
  //     'email': email,
  //     'password': password,
  //     'username': username,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formkey,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
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
              SvgPicture.asset(
                'assets/login_logo_emptybackg.svg',
                height: 140,
              ),
              const SizedBox(height: 50),

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
                  if (canPass()){
                      if (_formkey.currentState == null) {}
                      else if (_formkey.currentState!.validate()){
                        
                        final user = UserModel(email: controller.text_email.text.trim(),
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

//trying
  // Future addUserDetails(String email, String password, String username) async {
  //   await FirebaseFirestore.instance.collection('USER').add({
  //     'email': email,
  //     'password': password,
  //     'username': username,
  //   });
  // }

  bool canPass() {
    if (controller.text_pass.text.trim() != controller.text_check.text.trim()) {
      print("password is not verified!");
      return false;
    } else if (controller.text_username.text.isEmpty) {
      print("Enter a valid username.");
      return false;
    } else if (controller.text_email.text.isEmpty) {
      print("Enter a valid email.");
      return false;
    }
    return true;
  }

}
