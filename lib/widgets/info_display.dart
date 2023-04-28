import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:sportshive/screens/preference_screen.dart';
import 'package:sportshive/utils/global_variables.dart' as globals;

import '../data/models/user_model.dart';

class StatsInfo extends StatefulWidget {
  String name;
  int age;
  String country;
  String gender;
  double weight;
  double height;
  String bio;

  StatsInfo({
    Key? key,
    this.name = '',
    this.age = 0,
    this.country = '',
    this.gender = '',
    this.weight = 0,
    this.height = 0,
    this.bio = '',
  }) : super(key: key);

  Future<Map<String, dynamic>?> get_user_data() async {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('USER')
        .where('email', isEqualTo: userEmail)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> user = querySnapshot.docs.first.data();
      // name = user["first_name"] + user["last_name"];
      // age = user["dob"];
      // country = user["nationality"];
      // weight = user["weight"];
      // height = user["height"];
      // bio = user["desc"];
      return user;
    }
    // return null if user with provided email does not exist
    return null;
  }

  @override
  _StatsInfoState createState() => _StatsInfoState();
}

Future<Map<String, dynamic>?> get_user_data() async {
  String userEmail = FirebaseAuth.instance.currentUser!.email!;
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection('USER')
      .where('email', isEqualTo: userEmail)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    Map<String, dynamic> user = querySnapshot.docs.first.data();

    return user;
  }
  // return null if user with provided email does not exist
  return null;
}

class _StatsInfoState extends State<StatsInfo> {
  File? _image;

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      print('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get_user_data(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic>? user_data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User's photo on the left
                  Container(
                    width: 120,
                    height: 300,
                    decoration: BoxDecoration(
                      border: _image == null
                          ? Border.all(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        if (_image != null)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        if (_image == null) // Add this condition
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  _pickImage(context);
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // User's information on the right
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${user_data!["first_name"]} ${user_data["last_name"]}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Sports: ${globals.selectedSports.join(", ")}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                           const SizedBox(height: 10),
                          Text(
                            'Age: ${user_data["age"]}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Country: ${user_data["nationality"]}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            // Added gender
                            'Gender: M',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            // Added weight
                            'Weight: ${user_data["weight"]} kg',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            // Added height
                            'Height: ${user_data["height"]} cm',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'About: ${user_data["desc"]}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Something went wrong"),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
