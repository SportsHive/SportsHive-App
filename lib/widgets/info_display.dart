import 'package:flutter/material.dart';

class StatsInfo extends StatelessWidget {
  final String photoUrl;
  final String name;
  final int age;
  final String country;
  final String gender; // Added gender
  final double weight; // Added weight
  final double height;
  final String bio;
  //final List<String> interestedSports;

  const StatsInfo({
    Key? key,
    this.photoUrl = '',
    this.name = '',
    this.age = 0,
    this.country = '',
    this.gender = '', // Initialize gender
    this.weight = 0, // Initialize weight
    this.height = 0,
    this.bio = '',
    //required this.interestedSports, // Initialize height
  }) : super(key: key);

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
              border: Border.all(
                color: Colors.grey,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                if (photoUrl != null && photoUrl.isNotEmpty)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        photoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // TODO: Implement image upload logic
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
                    'Name: $name',
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
                    'Age: $age',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Country: $country',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // Added gender
                    'Gender: $gender',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // Added weight
                    'Weight: ${weight.toStringAsFixed(1)} kg',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // Added height
                    'Height: ${height.toStringAsFixed(1)} cm',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'About: $bio',
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
