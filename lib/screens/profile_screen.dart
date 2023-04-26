import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportshive/data/controllers/profile_controller.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';
import 'package:sportshive/data/repositories/user_repo.dart';
import 'package:sportshive/screens/editprofile_page.dart';
import 'package:sportshive/utils/colors.dart';

import '../../data/models/user_model.dart';
import '../../widgets/custom_option.dart';

//for popups
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:sportshive/screens/popup_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  static bool profileIsForCurrentUser() {
    /**
     * change when search is implemented to have different
     * behavior for a different user on the profile screen
     */
    return true;
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
      icon: Icon(Icons.logout),
      onPressed: () {
        // Add code here to log out the user
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: FutureBuilder(
            future: userRepo.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user_data = snapshot.data as UserModel;
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
                                    child: Image.asset("assets/images/user_default_profile_picture.png", height: 50)
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
                                child: Text(user_data.username),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        user_data.followers.toString(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Posts")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        user_data.followers.toString(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Followers")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        user_data.following.toString(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Following")
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
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
                                        child: Text("Edit Profile"),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 10), // add space between buttons
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          PopupHelper.showSignOutPopup(
                                              context, 'POP_SignOut');
                                            Future.delayed(Duration(seconds: 3)).then((value) => AuthenticationRepository.instance.logOut());
                                            
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.redAccent,
                                          onPrimary: Colors.white,
                                        ),
                                        child: Text("Log Out"),
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
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          children: [CustomTernaryOption()],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Center(child: Text("Something went wrong..."));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
