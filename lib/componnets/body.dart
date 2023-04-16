import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportshive/componnets/rounded_button.dart';
import 'package:sportshive/screens/auth/login_page.dart';
import 'package:sportshive/screens/auth/signup_page.dart';

import '../screens/auth/welcome_screen.dart';
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
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset("assets/images/welcome.svg",
              height: size.height * 0.41),
          RoundedButton(
            text: "LOG IN",
            press: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));},
          ),
          RoundedButton(
            text: "SIGN UP",
            textColor: Colors.black,
            color: Colors.orangeAccent,
            press: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));},
          ),
        ],
      ),
    );
  }
}
