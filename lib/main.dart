import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';
import 'package:sportshive/responsive/mobile_screen_layout.dart';
import 'package:sportshive/screens/create_events_screen.dart';
import 'package:sportshive/screens/editprofile_page.dart';
import 'package:sportshive/screens/popup_page.dart';
import 'package:sportshive/screens/welcome_screen.dart';
import 'package:sportshive/screens/add_post_screen.dart';

import 'package:sportshive/utils/colors.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SportsHive',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: UserProfileScreen(),
    );
  }
}
