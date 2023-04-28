import 'package:flutter/material.dart';

class PostsWidget extends StatefulWidget {
  @override
  _PostsWidgetState createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> {
  List<Post> _posts = [];

  @override
  Widget build(BuildContext context) {
    if (_posts.isEmpty) {
      return Center(
        child: Text('Oops, you haven\'t posted yet.'),
      );
    } else {
      return GridView.builder(
        itemCount: _posts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Text(_posts[index].title),
          );
        },
      );
    }
  }
}

class Post {
  final String title;
  final String content;

  Post(this.title, this.content);
}
