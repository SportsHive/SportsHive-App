import 'package:flutter/material.dart';



class SportsPreferenceScreen extends StatefulWidget {
  @override
  _SportsPreferenceScreenState createState() => _SportsPreferenceScreenState();
}

class _SportsPreferenceScreenState extends State<SportsPreferenceScreen> {
  List<String> selectedSports = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            _buildSportsIcon('Football', Icons.sports_soccer),
            _buildSportsIcon('Basketball', Icons.sports_basketball),
            _buildSportsIcon('Rugby', Icons.sports_rugby),
            _buildSportsIcon('Tennis', Icons.sports_tennis),
            _buildSportsIcon('Baseball', Icons.sports_baseball),
            _buildSportsIcon('MMA', Icons.sports_mma),
            _buildSportsIcon('Maui Thai', Icons.sports_martial_arts),
            _buildSportsIcon('American', Icons.sports_football_sharp),
            _buildSportsIcon('Crossfit', Icons.sports_gymnastics),
            _buildSportsIcon('Hockey', Icons.sports_hockey),
            _buildSportsIcon('Handball', Icons.sports_handball),
            _buildSportsIcon('Cricket', Icons.sports_cricket),
            _buildSportsIcon('Esports', Icons.sports_esports),
            _buildSportsIcon('Volleyball', Icons.sports_volleyball),
      
          ],
        ),
      ),
      
      
      floatingActionButton: FloatingActionButton(
        onPressed: _onDonePressed,
        child: Icon(Icons.check),
      ),
      
      
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

Widget _buildSportsIcon(String sportName, IconData iconData) {
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
      
      padding: EdgeInsets.all(5.0), // Adjust the amount of padding as needed
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50.0,
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
    // Implement your logic here
    Navigator.of(context).pop();
  }
}
