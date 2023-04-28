import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportshive/screens/create_awards_screen.dart';

class Award {
  final String imagePath;
  final String title;

  Award({required this.imagePath, required this.title});
}

class AwardsWidget extends StatefulWidget {
  @override
  _AwardsWidgetState createState() => _AwardsWidgetState();
}

class _AwardsWidgetState extends State<AwardsWidget> {
  List<Award?> awards = List.generate(9, (index) => null);

  void onAwardCreated(Award award, int index) async {
    setState(() {
      awards[index] = award;
    });

    // Save awards to local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> awardsList = awards
        .map(
            (award) => award != null ? '${award.imagePath}:${award.title}' : '')
        .toList();
    prefs.setStringList('awards', awardsList);
  }

  @override
  void initState() {
    super.initState();
    // Load awards from local storage
    loadAwards();
  }

  Future<void> loadAwards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> awardsList =
        prefs.getStringList('awards') ?? List.generate(9, (index) => '');
    List<Award?> loadedAwards = awardsList.map((awardString) {
      if (awardString.isEmpty) {
        return null;
      }
      List<String> awardData = awardString.split(':');
      return Award(imagePath: awardData[0], title: awardData[1]);
    }).toList();
    setState(() {
      awards = loadedAwards;
    });
  }

  Future<void> saveAwards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> awardsList = awards
        .map((award) =>
            award != null ? '${award!.imagePath}:${award!.title}' : '')
        .toList();
    prefs.setStringList('awards', awardsList);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: SingleChildScrollView(
          child: Flexible(
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 1.1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(awards.length, (index) {
                return InkWell(
                  onTap: () {
                    if (awards[index] == null) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CreateAwardsPage(
                            onAwardCreated: (newAward) {
                              onAwardCreated(newAward, index);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Remove Award'),
                            content: Text(
                                'Are you sure you want to remove this award?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    awards[index] = null;
                                  });
                                  // Save awards to local storage
                                  saveAwards();
                                  Navigator.pop(context);
                                },
                                child: Text('Remove'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: awards[index] == null
                            ? Colors.grey
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: awards[index] != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  awards[index]!.imagePath,
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(height: 4),
                                Flexible(
                                  child: Text(
                                    awards[index]!.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Icon(Icons.add, size: 60, color: Colors.grey),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
