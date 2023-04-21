import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  String? _selectedSport;
  int _selectedAvailability = 1;
  DateTime _selectedDate = DateTime.now();
  LatLng? _selectedLocation;

  final _sports = [
    'Football',
    'BasketBall',
    'American Football',
    'boxing',
    'cycling',
    'hiking',
    'Muay Thai',
    'MMA',
    'Rugby',
    'Skiing',
    'Swimming',
    'Table Tennis',
    'Tennis',
    'Track',
    'VolleyBall',
    'WeightLifting',
    'Wrestling',
    'Yoga'
  ];

  File? _imageFile;

  final _availabilityValues = List<int>.generate(20, (i) => i + 1);

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

  void _handleLocationSelection(LatLng? value) {
    setState(() {
      _selectedLocation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
        backgroundColor: Colors.orange,
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

              SizedBox(height: 16.0),

              // Title input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
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
                decoration: InputDecoration(
                  hintText: 'Please provide the a google maps link to the location',
                ),
                keyboardType: TextInputType
                    .url, // set the keyboard type to url for better user experience
                onChanged: (value) {
                  // do something with the user input
                },
              ),

              SizedBox(height: 80.0),

              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
