import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportshive/data/controllers/profile_controller.dart';
import 'package:sportshive/data/repositories/user_repo.dart';
import 'package:sportshive/screens/editprofile_page.dart';
import 'package:sportshive/utils/colors.dart';

import '../../data/models/user_model.dart';
import '../../widgets/custom_option.dart';

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
                                    backgroundImage: AssetImage(
                                        "assets/images/profilepicsample.png"),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.orangeAccent,
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                    ),
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
                                                UserProfileScreen()),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .orange, // Set the background color
                                    onPrimary:
                                        Colors.white, // Set the text color
                                  ),
                                  child: Text(followButtonText),
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
