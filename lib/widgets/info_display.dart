import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';


class StatsInfo extends StatefulWidget {
  final String name;
  final int age;
  final String country;
  final String gender;
  final double weight;
  final double height;
  final String bio;

  const StatsInfo({
    Key? key,
    this.name = '',
    this.age = 0,
    this.country = '',
    this.gender = '',
    this.weight = 0,
    this.height = 0,
    this.bio = '',
  }) : super(key: key);

  @override
  _StatsInfoState createState() => _StatsInfoState();
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
                    'Name: ${widget.name}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Text(
                  //   // Added interestedSports
                  //   'Interested Sports: ${interestedSports.join(", ")}',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //   ),
                  // ),
                  Text(
                    'Age: ${widget.age}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Country: ${widget.country}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // Added gender
                    'Gender: ${widget.gender}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // Added weight
                    'Weight: ${widget.weight.toStringAsFixed(1)} kg',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // Added height
                    'Height: ${widget.height.toStringAsFixed(1)} cm',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'About: ${widget.bio}',
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
  }
}
