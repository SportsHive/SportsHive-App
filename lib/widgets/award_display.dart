import 'package:flutter/material.dart';

class AwardsWidget extends StatelessWidget {
  final List<String> awardImages = [
    'assets/awards/Gold_Medal.png',
    'assets/awards/Silver_Medal.png',
    'assets/awards/Bronze_Medal.png',
    'assets/awards/Trophey1.png',
    'assets/awards/Belt.png',
    'assets/awards/Belt.png',

  ];

  final List<String> awardTitles = [
    '1st Place ',
    '2nd 100m Race',
    '3rd Place Wrestling',
    'Football Tournmanet',
    'Middle Weight MMA Champion',
    'Welter Weight MMA Champion',

  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SingleChildScrollView(
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: List.generate(awardImages.length, (index) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    awardImages[index],
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      awardTitles[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
