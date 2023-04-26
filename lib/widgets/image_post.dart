import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ImagePost extends StatefulWidget {
  final String username;
  final String caption;
  final String imageUrl;
  final int likes;
  final int commentCount;

  const ImagePost({
    Key? key,
    required this.username,
    required this.caption,
    required this.imageUrl,
    this.likes = 0,
    this.commentCount = 0,
  }) : super(key: key);

  @override
  State<ImagePost> createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.account_circle, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  widget.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.caption,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.white,
                        ),
                        Text(
                          widget.likes.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_bubble_outline),
                          color: Colors.white,
                        ),
                        Text(
                          widget.commentCount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
