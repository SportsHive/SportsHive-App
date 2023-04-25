import 'package:flutter/material.dart';
import 'package:sportshive/components/rounded_button.dart';
import 'package:sportshive/utils/colors.dart';

class CreateAwardsPage extends StatefulWidget {
  const CreateAwardsPage({Key? key}) : super(key: key);

  @override
  _CreateAwardsPageState createState() => _CreateAwardsPageState();
}

class _CreateAwardsPageState extends State<CreateAwardsPage> {
  String? selectedAward;
  final List<String> awardIcons = [
    'assets/awards/Belt.png',
    'assets/awards/White_belt.png',
    'assets/awards/Yellow_Belt.png',
    'assets/awards/Brown_belt.png',
    'assets/awards/Black_belt.png',
    'assets/awards/Participation.png',
    'assets/awards/Gold_Medal.png',
    'assets/awards/Bronze_Medal.png',
    'assets/awards/Silver_Medal.png',
    'assets/awards/Trophey1.png',
    'assets/awards/Trophey2.png',
    'assets/awards/Trophey3.png',
  ];
  final TextEditingController awardNameController = TextEditingController();

  void selectAward(int index) {
    setState(() {
      selectedAward = awardIcons[index];
    });
  }

  @override
  void dispose() {
    awardNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        title: Text('Create Award'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: awardNameController,
              decoration: InputDecoration(
                labelText: 'Whats the name of your award',
              ),
            ),
            SizedBox(height: 30.0),
            Text('What Icon best describes your award:'),
            SizedBox(height: 20.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 1.0,
                children: List.generate(awardIcons.length, (index) {
                  return GestureDetector(
                    onTap: () => selectAward(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.all(
                          selectedAward == awardIcons[index] ? 5.0 : 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            selectedAward == awardIcons[index] ? 10.0 : 0.0),
                        color: selectedAward == awardIcons[index]
                            ? Colors.blue.withOpacity(0.5)
                            : null,
                      ),
                      child: Image.asset(
                        awardIcons[index],
                        width: 40,
                        height: 40,
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                  color: orange,
                  press: () {
                    if (selectedAward != null &&
                        awardNameController.text.isNotEmpty) {
                      // Save the award and the name
                    }
                  },
                  text: "Create",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}