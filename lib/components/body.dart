import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportshive/components/rounded_button.dart';
import 'package:sportshive/screens/login_page.dart';
import 'package:sportshive/screens/signup_page.dart';
import 'package:sportshive/utils/colors.dart';

import '../screens/welcome_screen.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Welcome to SportsHive",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Image.asset("assets/WEL.png", height: size.height * 0.41),
          RoundedButton(
            text: "LOG IN",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
          RoundedButton(
            text: "SIGN UP",
            textColor: Colors.black,
            color: orange,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
            },
          ),
        ],
      ),
    );
  }
}
