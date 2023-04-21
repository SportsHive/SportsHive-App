import 'package:flutter/material.dart';
import 'package:sportshive/screens/auth/add_post_screen.dart';
import 'package:sportshive/screens/auth/create.dart';
import 'package:sportshive/screens/auth/event_page.dart';
import 'package:sportshive/screens/auth/home_page.dart';

import '../screens/auth/profile_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  EventsScreen(),
  HomePage(),
  CreatePost(),
  ProfileScreen(),
];
