import 'package:flutter/material.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';
import 'package:sportshive/data/repositories/user_repo.dart';
import 'package:sportshive/utils/colors.dart';

import '../../data/models/user_model.dart';
import '../../widgets/custom_option.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final userRepo = UserRepository();
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
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
                          backgroundImage:
                              AssetImage("assets/images/profilepicsample.png"),
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
                      child: Text("John Cena"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "32",
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
                              "32",
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
                              "32",
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
                          
                        },
                        child: Text('Follow'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange, // Set the background color
                          onPrimary: Colors.white, // Set the text color
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final authRepo = AuthenticationRepository();
                          authRepo.logOut();
                        },
                        child: Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange, // Set the background color
                          onPrimary: Colors.white, // Set the text color
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              color: mobileBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  CustomTernaryOption()
                  
                  
                  
                  ],

              ),
            )
          ],
        ),
      ),
    );
  }
}