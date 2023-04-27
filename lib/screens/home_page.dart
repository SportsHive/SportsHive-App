import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:sportshive/widgets/image_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportshive/widgets/error_post_unloadable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        // appBar:
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("POSTS").snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Show error message if there's an error in the stream
              } else if (!snapshot.hasData) {
                return const Text(
                    'Error: No data available'); // Show a message if no data is available
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                // itemBuilder: (context, index) => ImagePost(
                //       caption: snapshot.data!.docs[index].data().get('caption'),
                //     ));
                itemBuilder: (context, index) {
                  try {
                    QueryDocumentSnapshot<Map<String, dynamic>> post =
                        snapshot.data!.docs[index];

                    return ImagePost(
                      username: post.get('username'),
                      caption: post.get('caption'),
                      imageUrl: post.get('image_url'),
                      likes: post.get('likes'),
                      commentCount: post.get('comment_count'),
                    );
                  } catch (e) {
                    return const ErrorPostUnloadable();
                  }
                },
              );
            })
        // body: SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: SingleChildScrollView(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: header,
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
