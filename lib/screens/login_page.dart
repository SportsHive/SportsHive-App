import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportshive/components/background.dart';
import 'package:sportshive/components/rounded_button.dart';
import 'package:sportshive/responsive/mobile_screen_layout.dart';
import 'package:sportshive/responsive/mobile_screen_layout.dart';
import 'package:sportshive/responsive/mobile_screen_layout.dart';
import 'package:sportshive/screens/event_page.dart';
import 'package:sportshive/screens/preference_screen.dart';
import 'package:sportshive/screens/profile_screen.dart';
import 'package:sportshive/screens/welcome_screen.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:sportshive/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: orange,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      body: Background(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
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

              const SizedBox(height: 35),
              //textfield for email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                borderColor: const Color.fromARGB(255, 0, 0, 0),
                borderWidth: 2.0,
                borderRadius: 15.0,
              ),
              //textfield for password
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _passController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
                prefixIcon: Icons.lock,
                borderColor: Colors.black,
                borderWidth: 2.0,
                borderRadius: 15.0,
              ),
              //button for login
              const SizedBox(height: 29),

              InkWell(
                child: RoundedButton(
                  color: orange,
                  text: 'Log In',
                  press: () async {
                    User? user = await loginWithEmail(
                        email: _emailController.text.trim(),
                        password: _passController.text.trim(),
                        context: context);

                    if (user != null) {
                      //Instead of WelcomeScreen, We can put any page we want after login in
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MobileScreenLayout()));
                    }
                  },
                ),
              ),

              const SizedBox(height: 12),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //Transition to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 1,
                    ),
                    child: const Text("Don't have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: const Text(" Sign Up !",
                          style: TextStyle(fontWeight: FontWeight.bold)),
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

  static Future<User?> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential usercred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = usercred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User Registered");
      }
    }
    return user;
  }
}
