import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportshive/components/background.dart';
import 'package:sportshive/utils/colors.dart';

import '../components/rounded_button.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final picker = ImagePicker();
  File _image = File('/assets/images/background.jpeg');
  String _caption = '';
  List<String> _selectedSports = [];

  void _selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitPost() {
    // Implement your logic to submit the post
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Post',
          style: TextStyle(
            color:
                mobileBackgroundColor, // Change this to the color you want for the title
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(
          color: mobileBackgroundColor, // Change this to the color you want for the back arrow
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: _selectImage,
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Visibility(
                    visible: _image == null,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.grey[800],
                      size: 80.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              TextField(
                onChanged: (value) {
                  _caption = value;
                },
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: mobileBackgroundColor,
                ),
              ),
              SizedBox(height: 25.0),
              Text('Select sports:'),
              Wrap(
                children: [
                  _buildSportChip('Football'),
                  _buildSportChip('Basketball'),
                  _buildSportChip('Tennis'),
                  _buildSportChip('MMA'),
                  _buildSportChip('Baseball'),
                  _buildSportChip('Hockey'),
                  _buildSportChip('American Football'),
                  _buildSportChip('Boxing'),
                  _buildSportChip('Cycling'),
                  _buildSportChip('Hiking'),
                  _buildSportChip('Mauy Thai'),
                  _buildSportChip('Rugby'),
                  _buildSportChip('Skiing'),
                  _buildSportChip('Swimming'),
                  _buildSportChip('Table Tennis'),
                  _buildSportChip('Track'),
                  _buildSportChip('Volleyball'),
                  _buildSportChip('WeightLifting'),
                  _buildSportChip('Wrestling'),
                  _buildSportChip('Yoga'),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              RoundedButton(
                text: 'POST',
                press: () {},
                color: mobileBackgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSportChip(String sport) {
    final isSelected = _selectedSports.contains(sport);
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        selected: isSelected,
        label: Text(sport),
        selectedColor: Colors.orange,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedSports.add(sport);
            } else {
              _selectedSports.remove(sport);
            }
          });
        },
      ),
    );
  }
}
