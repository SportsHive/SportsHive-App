import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportshive/componnets/background.dart';
import 'package:sportshive/componnets/rounded_button.dart';
import 'package:sportshive/screens/auth/welcome_screen.dart';
import 'package:sportshive/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _checkController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _checkController.dispose();
    _bioController.dispose();
    _userController.dispose();
  }

//function to sign Up users
Future signUp() async {
  if (_checkController.text.trim() == _passController.text.trim()) {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text.trim(),
    password: _passController.text.trim());
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SvgPicture.asset(
                'assets/login_logo_emptybackg.svg',
                height: 140,
              ),
              const SizedBox(height: 50),

              //textfield for username
              TextFieldInput(
                textEditingController: _userController,
                hintText: 'Create a username',
                textInputType: TextInputType.text,
                prefixIcon: Icons.person,
                borderColor: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: 15,
                borderWidth: 2.0,
              ),
              const SizedBox(height: 24),
              //textfield for email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                borderColor: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: 15,
                borderWidth: 2.0,
              ),

              const SizedBox(height: 24),
              //textfield for password
              TextFieldInput(
                textEditingController: _passController,
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
              TextFieldInput(
                textEditingController: _checkController,
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
                  press: signUp,

                  //bdeirs old code:
                  // child: const Text('Register Now!'),
                  // width: double.infinity,
                  // alignment: Alignment.center,
                  // padding: const EdgeInsets.symmetric(vertical: 12),
                  // decoration: const ShapeDecoration(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(4),
                  //       ),
                  //     ),
                  //     color: orange),
                ),
              ),

              const SizedBox(height: 24),
              InkWell(
                child: RoundedButton(
                  text: 'Back to Homepage',
                  press: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));},
                ),
              ),


              const SizedBox(height: 1),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              //Transition to sign up
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle the "Login with Google" button press
                        },
                        child: const Text('Login with Google'),
                      ),
                    ),
                    const SizedBox(
                        width: 16), // Add some spacing between the buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle the "Login with Apple" button press
                        },
                        child: const Text('Login with Apple'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
