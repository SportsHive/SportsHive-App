import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportshive/data/controllers/profile_controller.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';
import 'package:sportshive/data/repositories/user_repo.dart';
import 'package:sportshive/responsive/mobile_screen_layout.dart';
import 'package:sportshive/screens/editprofile_page.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:sportshive/utils/global_variables.dart';
import '../../data/models/user_model.dart';
import '../../widgets/custom_option.dart';

//for popups
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:sportshive/screens/popup_page.dart';

import '../widgets/award_display.dart';
import '../widgets/info_display.dart';

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("PostWidget"));
  }
}

class AwardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("AwardWidget"));
  }
}

class StatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("StatsWidget"));
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;

  Widget _buildSelectedContent() {
    switch (_selectedIndex) {
      case 0:
        return PostWidget(); // Replace with your actual PostWidget
      case 1:
        return AwardsWidget();
      case 2:
        return const StatsInfo(); // Replace with your actual StatsWidget
      default:
        return Container();
    }
  }

  static bool profileIsForCurrentUser() {
    /**
     * change when search is implemented to have different
     * behavior for a different user on the profile screen
     */
    if (FirebaseAuth.instance.currentUser == null) {
      //not logged in logic
      return false;
    } else if (desiredProfileUsername ==
        FirebaseAuth.instance.currentUser!.displayName) {
      return true;
    }

    return false;
  }

  static bool isFollowing() {
    /**
     * change to check database and see if
     * the person navigating follows the person
     * who's profile is being displayed
     */
    return false;
  }

  static void updateFollow() {
    /**
     * change to check database and see if
     * the person navigating follows the person
     * who's profile is being displayed
     */
    if (isFollowing()) {
      return;
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRepo = Get.put(UserRepository());
    userRepo.initState();

    var followButtonText = '';
    if (profileIsForCurrentUser()) {
      followButtonText = "Edit profile";
    } else if (isFollowing()) {
      followButtonText = "Unfollow";
    } else {
      followButtonText = "Follow";
    }
    IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        // Add code here to log out the user
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: FutureBuilder(
            future: profileIsForCurrentUser()
                ? userRepo.getUserData()
                : userRepo.getUserDetailsByUsername(desiredProfileUsername),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    children: [
                      Container(
                        color: mobileBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                      radius: 50,
                                      child: Image.asset(
                                          "assets/images/user_default_profile_picture.png",
                                          height: 50)
                                      // InkWell(
                                      //   onTap: () {}, //option to change the image: icon disabled until supported
                                      //   child: CircleAvatar(
                                      //     radius: 15,
                                      //     backgroundColor: orange,
                                      //     child: Icon(
                                      //       Icons.edit,
                                      //       size: 20,
                                      //     ),
                                      //   ),
                                      // )
                                      )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(userData.username),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Column(
                                  //   children: [
                                  //     Text(
                                  //       userData.followers.toString(),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 10,
                                  //     ),
                                  //     Text("Posts")
                                  //   ],
                                  // ),
                                  Column(
                                    children: [
                                      Text(
                                        userData.followers.toString(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Followers")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        userData.following.toString(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Following")
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (!profileIsForCurrentUser()) {
                                            updateFollow();
                                            setState(() {
                                              followButtonText = isFollowing()
                                                  ? 'Unfollow'
                                                  : 'Follow';
                                            });
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfileScreen(),
                                              ),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: orange,
                                          onPrimary: Colors.white,
                                        ),
                                        child: const Text("Edit Profile"),
                                      ),
                                    ),
                                    const SizedBox(
                                        width: 10), // add space between buttons
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          PopupHelper.showSignOutPopup(
                                              context, 'POP_SignOut');
                                          Future.delayed(
                                                  const Duration(seconds: 3))
                                              .then((value) =>
                                                  AuthenticationRepository
                                                      .instance
                                                      .logOut());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.redAccent,
                                          onPrimary: Colors.white,
                                        ),
                                        child: const Text("Log Out"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        color: mobileBackgroundColor,
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          children: [
                            CustomTernaryOption(
                              textLeft: "Posts",
                              textMiddle: "Awards",
                              textRight: "Info",
                              selectedOption: _selectedIndex,
                              onOptionSelected: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                            ),
                            // Add the Stack widget here with the _buildSelectedContent method
                            _buildSelectedContent(),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong..."));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
