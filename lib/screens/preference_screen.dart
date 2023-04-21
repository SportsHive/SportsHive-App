import 'package:flutter/material.dart';
import 'package:sportshive/components/background.dart';
import 'package:sportshive/screens/editprofile_page.dart';

import '../../responsive/mobile_screen_layout.dart';

class SportsPreferenceScreen extends StatefulWidget {
  @override
  _SportsPreferenceScreenState createState() => _SportsPreferenceScreenState();
}

class _SportsPreferenceScreenState extends State<SportsPreferenceScreen> {
  List<String> selectedSports = [];

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Your Preferred Sport(s)'),
          backgroundColor: Colors.orange,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              _buildSportsImage('assets/icons/football.png', 'Football'),
              _buildSportsImage('assets/icons/basketball.png', 'Basketball'),
              _buildSportsImage('assets/icons/rugby.png', 'Rugby'),
              _buildSportsImage('assets/icons/tennis.png', 'Tennis'),
              _buildSportsImage('assets/icons/cycling.png', 'Cycling'),
              _buildSportsImage('assets/icons/boxing.png', 'Boxing'),
              _buildSportsImage('assets/icons/mauy_thai.png', 'Mauy Thai'),
              _buildSportsImage(
                  'assets/icons/american_football.png', 'American'),
              _buildSportsImage('assets/icons/hiking.png', 'Hiking'),
              _buildSportsImage('assets/icons/MMA.png', 'MMA'),
              _buildSportsImage('assets/icons/weightlift.png', 'WeightLifting'),
              _buildSportsImage('assets/icons/track.png', 'Track'),
              _buildSportsImage('assets/icons/swimming.png', 'Swimming'),
              _buildSportsImage('assets/icons/volleyball.png', 'Volleyball'),
              _buildSportsImage('assets/icons/wrestling.png', 'Wrestling'),
              _buildSportsImage('assets/icons/yoga.png', 'Yoga'),
              _buildSportsImage('assets/icons/skiing.png', 'Skiing'),
              _buildSportsImage(
                  'assets/icons/table_tennis.png', 'Table Tennis'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onDonePressed,
          child: Icon(Icons.check),
          backgroundColor: Colors.orange,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildSportsImage(String imagePath, String sportName) {
    bool isSelected = selectedSports.contains(sportName);

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedSports.remove(sportName);
          } else {
            selectedSports.add(sportName);
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.orange : Colors.grey,
              width: 2.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 50.0,
                height: 50.0,
              ),
              SizedBox(height: 10.0),
              Text(
                sportName,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDonePressed() {
    // Navigate to MobileScreenLayout
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfileScreen()),
    );
  }
}
