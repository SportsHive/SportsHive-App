import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';
import 'package:sportshive/screens/auth/add_post_screen.dart';
import 'package:sportshive/screens/auth/create.dart';
import 'package:sportshive/screens/auth/event_page.dart';
import 'package:sportshive/screens/auth/login_page.dart';
import 'package:sportshive/screens/auth/preference_screen.dart';
import 'package:sportshive/screens/auth/profile_pic.dart';
import 'package:sportshive/screens/auth/profile_screen.dart';
import 'package:sportshive/screens/auth/signup_page.dart';
import 'package:sportshive/screens/auth/welcome_screen.dart';
import 'package:sportshive/screens/auth/editprofile_page.dart';
import 'package:sportshive/utils/colors.dart';
import 'responsive/mobile_screen_layout.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
  .then((value) => Get.put(AuthenticationRepository()));
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
      home: WelcomeScreen(),
    );
  }
}
