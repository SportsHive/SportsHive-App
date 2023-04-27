import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:sportshive/screens/welcome_screen.dart";
import "package:sportshive/utils/colors.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  _SearchScreenState createState() => _SearchScreenState();
}
class SelectedUser {
  static String username = "";
}



class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchCont = TextEditingController();
  String name = "";
  String selectedUsername="";
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
                             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
                             selectedUsername = data["username"];
                            SelectedUser.username = selectedUsername; 
                            Get.snackbar(selectedUsername,
          "Try uploading smaller image",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(1),
          colorText: Colors.black);
                            
                          },
                          child: ListTile(
                            title: Text(
                              data["username"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: CircleAvatar(
                                child: Image.asset(data["avatar_url"])),
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

