import 'package:sportshive/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTernaryOption extends StatefulWidget {
  CustomTernaryOption({
    Key? key,
    this.textLeft = "Left",
    this.textMiddle = "Middle",
    this.textRight = "Right",
    required this.selectedOption, 
    required this.onOptionSelected,
    
  }) : super(key: key);

  String textLeft;
  String textMiddle;
  String textRight;
  int selectedOption;
  final Function(int) onOptionSelected;

  @override
  State<CustomTernaryOption> createState() => _CustomTernaryOptionState();
}

class _CustomTernaryOptionState extends State<CustomTernaryOption> {
  late int selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;
  }

  void _onOptionSelected(int index) {
    setState(() {
      selectedOption = index;
    });
    widget.onOptionSelected(selectedOption);
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: mobileBackgroundColor,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
  
                  _onOptionSelected(0);
                
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.textLeft,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selectedOption == 0 ? orange : Colors.white,
                        ),
                  ),
                  Container(
                    height: selectedOption == 0 ? 3 : 1,
                    color: selectedOption == 0 ? orange : Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
            _onOptionSelected(1);
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.textMiddle,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selectedOption == 1 ? orange : Colors.white,
                        ),
                  ),
                  Container(
                    height: selectedOption == 1 ? 3 : 1,
                    color: selectedOption == 1 ? orange : Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                  _onOptionSelected(2);
                
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.textRight,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selectedOption == 2 ? orange : Colors.white,
                        ),
                  ),
                  Container(
                    height: selectedOption == 2 ? 3 : 1,
                    color: selectedOption == 2 ? orange : Colors.white,
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
