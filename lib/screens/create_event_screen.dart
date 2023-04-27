import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportshive/utils/colors.dart';
import 'dart:io';

import '../data/models/event_model.dart';
import '../data/repositories/user_repo.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  String? _selectedSport;
  int _selectedAvailability = 1;
  DateTime _selectedDate = DateTime.now();

  final _sports = [
    'Football',
    'Basketball',
    'American Football',
    'Boxing',
    'Cycling',
    'Hiking',
    'Muay Thai',
    'MMA',
    'Rugby',
    'Skiing',
    'Swimming',
    'Table Tennis',
    'Tennis',
    'Track',
    'Volleyball',
    'Weightlifting',
    'Wrestling',
    'Yoga'
  ];
  File? _imageFile;
  String imageURL = "";

  final _availabilityValues = List<int>.generate(20, (i) => i + 1);
  final title_controller = TextEditingController();
  final location_controller = TextEditingController();
  final _db = FirebaseFirestore.instance;
  final userRepo = UserRepository();

  void _handleSportSelection(String? value) {
    setState(() {
      _selectedSport = value;
    });
  }

  void _handleAvailabilitySelection(int? value) {
    setState(() {
      _selectedAvailability = value ?? 1;
    });
  }

  void _handleDateSelection(DateTime value) {
    setState(() {
      _selectedDate = value;
    });
  }

  void _handleTimeSelection(TimeOfDay value) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, value.hour, value.minute);
    });
  }

  void addImageFile(File file) async {
    final storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("${userRepo.userData.username}/profile_pic.jpg");
    await ref.putFile(_imageFile!);
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        imageURL = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Event',
          style: TextStyle(
            color:
                mobileBackgroundColor, // Change this to the color you want for the title
          ),
        ),
        backgroundColor: orange,
        iconTheme: IconThemeData(
          color: mobileBackgroundColor,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo selection
              GestureDetector(
                onTap: () async {
                  final pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                  }
                  addImageFile(_imageFile!);
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _imageFile == null
                      ? Icon(Icons.photo, size: 50)
                      : Image.file(_imageFile!, fit: BoxFit.cover),
                ),
              ),

              // Title input
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: title_controller,
              ),
              SizedBox(height: 16.0),

              // Sport selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Sport',
                ),
                value: _selectedSport,
                onChanged: _handleSportSelection,
                items: _sports.map((sport) {
                  return DropdownMenuItem(
                    value: sport,
                    child: Text(sport),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),

              // Availability selection
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Availability',
                ),
                value: _selectedAvailability,
                onChanged: _handleAvailabilitySelection,
                items: _availabilityValues.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),

              // Date selection
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text:
                      '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                ),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null) {
                    _handleDateSelection(picked);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Date',
                ),
              ),

              //Time selection
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    _handleTimeSelection(picked);
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: '${_selectedDate.hour}:${_selectedDate.minute}',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Time',
                    ),
                  ),
                ),
              ),

              // Location selection
              SizedBox(height: 20.0),
              TextFormField(
                controller: location_controller,
                decoration: InputDecoration(
                  hintText:
                      'Provide a Google Maps or similar link to the location',
                ),
                keyboardType: TextInputType
                    .url, // set the keyboard type to url for better user experience
                onChanged: (value) {
                  // do something with the user input
                },
              ),

              SizedBox(height: 80.0),

              ElevatedButton(
                onPressed: () {
                  createEvent(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(orange),
                ),
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createEvent(context) async {
    //create an EventModel with the User informations
    EventsModel newEvent = EventsModel(
      title: title_controller.text.trim(),
      SportRelated: _selectedSport,
      posterURL: imageURL,
      seats_available: _selectedAvailability,
      seats_registered: 0,
      date: "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}",
      start_time: "${_selectedDate.hour}:${_selectedDate.minute}",
      location: location_controller.text.trim(),
      registered: List<String>.empty(),
    );

    //add the Event Model to the database
    await _db
        .collection("EVENT")
        .add(newEvent.toJson())
        .whenComplete(
          () => Get.snackbar(
              "Success", "Your SportsHive Event has been created successfully!",
              snackPosition: SnackPosition.TOP,
              backgroundColor: orange,
              colorText: Colors.black),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong! Try again.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(1),
          colorText: Colors.black);
      print(error.toString());
    });
  }
}
