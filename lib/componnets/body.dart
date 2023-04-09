import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportshive/componnets/rounded_button.dart';
import 'package:sportshive/utils/colors.dart';

import 'background.dart';



class Body extends StatelessWidget {
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
          SvgPicture.asset(
            "assets/images/welcome.svg",
            height: size.height * 0.4
            ),
        RoundedButton(
          text: "LOGIN",
          press:(){},
          ),
          RoundedButton(
          text: "SIGNUP",
          textColor: Colors.black,
          color: Colors.orangeAccent,
          press:(){},
          ),
        ],
      ),
    );
  }
}

