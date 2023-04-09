import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportshive/componnets/background.dart';
import 'package:sportshive/componnets/rounded_button.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:sportshive/widgets/text_field_input.dart';
import 'welcome_screen.dart';

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
      body: Background(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //svg image
              SvgPicture.asset(
                'assets/login_logo_emptybackg.svg',
                height: 140,
              ),
              const SizedBox(height: 35),
              //textfield for email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                borderColor: Color.fromARGB(255, 0, 0, 0),
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
                borderColor: Colors.red,
                borderWidth: 2.0,
                borderRadius: 15.0,
              ),
              //button for login
              const SizedBox(height: 29),

              InkWell(
                child: RoundedButton(
                  text: 'Log in',
                  press: () {
                    // Do something when the button is pressed
                  },

                  //bdeirs old button:
                  // child: const Text('Log in'),
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

              const SizedBox(height: 12),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //Transition to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Dont Have an Account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Text(" Sign Up !",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
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
}
