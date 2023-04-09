import 'package:flutter/material.dart';

import '../utils/colors.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedButton({
    super.key, 
    required this.text, 
    required this.press, 
    this.color = orange, 
    this.textColor = Colors.white,

  });



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical:10),
      width: size.width*0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          backgroundColor: Colors.orangeAccent),
          onPressed: press, 
          child:  Text(
            text,
             style: TextStyle(color:textColor)
          ),
          ),
      ),
    );
  }
}
