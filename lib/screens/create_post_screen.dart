import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportshive/components/background.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../components/rounded_button.dart';
import 'package:sportshive/data/repositories/user_repo.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final picker = ImagePicker();
  File _image = File('/assets/images/background.jpeg');
  String _caption = '';
  List<String> _selectedSports = [];
  bool _imageWasSelected = false;

  void _selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    _imageWasSelected = true;
  }

  Future<String> uploadImage(File imageFile) async {
    int maxImageSizeInKiloBytes = 4000;
    if (!await isFileSizeValid(maxImageSizeInKiloBytes)) {
      //allow maximum of 5000KB sized image
      Get.snackbar("Image is too large",
          "Try uploading an image smaller than ${maxImageSizeInKiloBytes / 1024}megabytes",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(1),
          colorText: Colors.black);
    }
    // create unique filename based on current time
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}';

    FirebaseStorage storage = FirebaseStorage.instance;

    // upload the image to firebase storage
    UploadTask uploadTask = storage.ref(fileName).putFile(imageFile);

    // wait for the upload to complete and get the download url
    TaskSnapshot snapshot = await uploadTask;

    String downloadImageURL = await snapshot.ref.getDownloadURL();
    return downloadImageURL;
  }

  Future<bool> isFileSizeValid(int maxSizeInKiloBytes) async {
    maxSizeInKiloBytes *= 1024; //convert from bytes to kilobytes
    if (!_imageWasSelected) {
      return false;
    }
    int fileSize = await _image.length();
    return fileSize <= maxSizeInKiloBytes;
  }

  Future<void> addDatabaseEntry(String imageURL) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('POST');
    final userRepo = Get.put(UserRepository());

    Map<String, dynamic> post = {
      'user': userRepo.userData.username,
      'timestamp': DateTime.now(),
      'selected_sports': _selectedSports,
      'caption': _caption,
      'image_url': imageURL,
    };
    await collection.add(post);
  }

  Future<bool> _submitPost() async {
    if (!_imageWasSelected) {
      Get.snackbar("Error", "You need to select an image",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(1),
          colorText: Colors.black);
      return false;
    }
    if (_caption == '') {
      Get.snackbar("Error", "It seems you forgot to write a caption!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(1),
          colorText: Colors.black);
      return false;
    }

    // Upload the image to Firebase Storage and get the download URL
    String imageURL = await uploadImage(_image);

    // Add the entry to Firestore
    await addDatabaseEntry(imageURL);
    Get.snackbar("Post uploaded successfully!", "",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.greenAccent.withOpacity(1),
        colorText: Colors.black);

    return true;
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
          color:
              mobileBackgroundColor, // Change this to the color you want for the back arrow
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
              // SizedBox(height: 25.0),
              // Text('Select sports:'),
              Wrap(
                children: [
                  _buildSportChip('Football'),
                  _buildSportChip('Basketball'),
                  _buildSportChip('Tennis'),
                  _buildSportChip('MMA'),
                  _buildSportChip('American Football'),
                  _buildSportChip('Boxing'),
                  _buildSportChip('Cycling'),
                  _buildSportChip('Hiking'),
                  _buildSportChip('Muay Thai'),
                  _buildSportChip('Rugby'),
                  _buildSportChip('Skiing'),
                  _buildSportChip('Swimming'),
                  _buildSportChip('Table Tennis'),
                  _buildSportChip('Track'),
                  _buildSportChip('Volleyball'),
                  _buildSportChip('Weightlifting'),
                  _buildSportChip('Wrestling'),
                  _buildSportChip('Yoga'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RoundedButton(
                text: 'POST',
                press: () {
                  _submitPost().then((postCreationSuccess) {
                    if (postCreationSuccess) {
                      Navigator.pop(context);
                    }
                  });
                },
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
