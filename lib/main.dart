import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sportshive/screens/auth/login_page.dart';
import 'package:sportshive/screens/auth/welcome_screen.dart';
import 'package:sportshive/utils/colors.dart';

import 'responsive/mobile_screen_layout.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/web_screen_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'SportsHive',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ReponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //    webScreenLayout: WebScreenLayout(),),
      home: WelcomeScreen(),
    );   
  }
}


