import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:sportshive/utils/colors.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchCont = TextEditingController();
  String name = "";

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
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: (snapshots.data! as dynamic).docs.length,
                    //chatgpt said replace with this to fix error: itemCount: snapshots.data?.docs.length ?? 0,

                    itemBuilder: (context, index) {
                      print(
                          "result: ${(snapshots.data! as dynamic).docs[index]["username"]} for name: ${name}");
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return ListTile(
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
                        );
                      }
                      if (data["username"]
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())) {
                        return ListTile(
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
                        );
                      }
                      return Container();
                    });
          }),
    );
  }
}

/*
 FutureBuilder(
        future: FirebaseFirestore.instance.collection("USER")
        .where("username", isGreaterThanOrEqualTo: searchText,).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              print("result: ${(snapshot.data! as dynamic).docs[index]["username"]}");
              return ListTile(
                leading: CircleAvatar(
                  child: Image.asset((snapshot.data! as dynamic).docs[index]["avatar_url"], height: 20,),
                ),
                title: Text((snapshot.data! as dynamic).docs[index]["username"]),
              );
            }
          );
        },
      
      )
      */