import 'package:flutter/material.dart';
import 'package:sportshive/components/rounded_button.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:sportshive/widgets/award_display.dart';

typedef OnAwardCreated = void Function(Award award);

class CreateAwardsPage extends StatefulWidget {
  final OnAwardCreated onAwardCreated;
  final Award? initialAward;

  const CreateAwardsPage({Key? key, required this.onAwardCreated, this.initialAward})
      : super(key: key);

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
  void initState() {
    super.initState();
    if (widget.initialAward != null) {
      selectedAward = widget.initialAward!.imagePath;
      awardNameController.text = widget.initialAward!.title;
    }
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
      title: Text(widget.initialAward == null ? 'Create Award' : 'Edit Award'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(70.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: awardNameController,
            decoration: InputDecoration(
              labelText: 'What is the name of your award?',
            ),
          ),
          SizedBox(height: 30.0),
          Text('What icon best describes your award?'),
          SizedBox(height: 20.0),
          Wrap(
            spacing: 30.0,
            runSpacing: 30.0,
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
                    width: 60,
                    height: 60,
                  ),
                ),
              );
            }),
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
                    widget.onAwardCreated(Award(
                      imagePath: selectedAward!,
                      title: awardNameController.text,
                    ));
                  }
                },
                text: "Create",
              ),
            ),
          ),
          if (widget.initialAward != null)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                  color: Colors.red,
                  press: () {
                    widget.onAwardCreated(Award(
                      imagePath: '',
                      title: '',
                    ));
                  },
                  text: "Remove",
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
}