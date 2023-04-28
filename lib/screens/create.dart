import 'package:flutter/material.dart';
import 'package:sportshive/screens/create_post_screen.dart';
import 'package:sportshive/screens/create_event_screen.dart';
import 'package:sportshive/screens/welcome_screen.dart';
import 'package:sportshive/utils/colors.dart';

import 'create_awards_screen.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePost> {
  Widget _buildElevatedButton(
    String label,
    IconData iconData,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 300,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: orange,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
    
            _buildElevatedButton(
              'Create Post',
              Icons.add,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPostScreen(),
                ),
              ),
            ),
            SizedBox(height: 40),
            // _buildElevatedButton(
            //   'Create Event',
            //   Icons.add,
            //   () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => CreateEventScreen(),
            //     ),
            //   ),
            // ),
            SizedBox(height: 40),
            _buildElevatedButton(
              'Add an Award',
              Icons.add,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
