import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sportshive/data/repositories/user_repo.dart';
import 'package:sportshive/screens/create_post_screen.dart';
import 'package:sportshive/screens/create.dart';
import 'package:sportshive/screens/event_page.dart';
import 'package:sportshive/screens/home_page.dart';
import 'package:sportshive/screens/create_post_screen.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';


import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  EventsScreen(),
  HomePage(),
  CreatePost(),
  ProfileScreen(),
];




String desiredProfileUsername = SelectedUser.username;
