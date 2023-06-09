import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportshive/screens/welcome_screen.dart';
import 'package:sportshive/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class SelectedUser {
  static String username = "";
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchCont = TextEditingController();
  String name = "";
  String selectedUsername = "";

  @override
  void dispose() {
    super.dispose();
    searchCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchCont,
          decoration: const InputDecoration(labelText: "Search for a user"),
          onChanged: (String value) {
            setState(() {
              name = value;
              print("value is : ${value}");
            });
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("USER").snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: (snapshots.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      print(
                          "result: ${(snapshots.data! as dynamic).docs[index]["username"]} for name: ${name}");
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty ||
                          data["username"]
                              .toString()
                              .toLowerCase()
                              .startsWith(name.toLowerCase())) {
                        return GestureDetector(
                          onTap: () {
                            selectedUsername = data["username"] ?? "";
                            SelectedUser.username;
                            Get.snackbar(selectedUsername,
                                "Try uploading a smaller image",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor:
                                    Colors.redAccent.withOpacity(1),
                                colorText: Colors.black);
                          },
                          child: ListTile(
                            title: Text(
                              data["username"] ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: CircleAvatar(
                              child: Image.asset(
                                data["avatar_url"] ?? "assets/images/default_avatar.png",
                              ),
                            ),
                          ),
                        );
                      }

                      return Container();
                    },
                  );
          }),
    );
  }
}
