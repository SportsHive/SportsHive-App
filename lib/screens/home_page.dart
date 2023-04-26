import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:sportshive/widgets/image_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Widget> samplePosts = [
  const SizedBox(height: 16.0),
  const ImagePost(
    username: 'Elie Stephan',
    imageUrl:
        'https://i.pinimg.com/736x/16/5d/b3/165db3322856da05fcf80106ae758430.jpg',
    caption: 'Beautiful view from my apartment today 😍',
    likes: 22131123,
    commentCount: 123132,
  ),
  const SizedBox(height: 16.0),
  const ImagePost(
    username: 'Moey Bdeir',
    imageUrl:
        'https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-article/002/240/392/d3773c5fb9e4bbe78430c05b8114de55_crop_exact.jpg',
    caption: 'This game was intense! 🔥🏀',
    likes: 420,
    commentCount: 8,
  ),
  const ImagePost(
    username: 'Maurice',
    imageUrl:
        'https://www.westend61.de/images/0001195189pw/man-playing-video-games-on-laptop.jpg',
    caption: 'Just chilling and playing some games 🎮',
    likes: 301,
    commentCount: 16,
  ),
  const ImagePost(
    username: 'Mehdi',
    imageUrl:
        'https://images.unsplash.com/photo-1597892653980-3cec697283fe?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG1hbiUyMHJ1bm5pbmd8ZW58MHx8MHx8&w=1000&q=80',
    caption: 'On that grind baby',
    likes: 69,
    commentCount: 69,
  ),
];

List<Widget> header = [
  const Text('Explore the latest news!',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 4.0,
              color: Colors.black,
              offset: Offset(1.0, 1.0),
            )
          ]))
];

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
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                // itemBuilder: (context, index) => ImagePost(
                //       caption: snapshot.data!.docs[index].data().get('caption'),
                //     ));
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot<Map<String, dynamic>> post =
                      snapshot.data!.docs[index];

                  return ImagePost(
                    username: post.get('username'),
                    caption: post.get('caption'),
                    imageUrl: post.get('image_url'),
                    likes: post.get('likes'),
                    commentCount: post.get('comment_count'),
                  );
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
