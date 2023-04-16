import 'package:sportshive/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTernaryOption extends StatefulWidget {
  CustomTernaryOption({
    Key? key,
    this.textLeft = "Posts",
    this.textMiddle = "Awards",
    this.textRight = "Stats",
  }) : super(key: key);

  String textLeft;
  String textMiddle;
  String textRight;

  @override
  State<CustomTernaryOption> createState() => _CustomTernaryOptionState();
}

class _CustomTernaryOptionState extends State<CustomTernaryOption> {
  int selectedOption = 0;

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
                  if (selectedOption != 0) {
                    setState(() {
                      selectedOption = 0;
                    });
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.textLeft,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: selectedOption == 0
                                ? Colors.orange
                                : Colors.white,
                          ),
                    ),
                    Container(
                      height: selectedOption == 0 ? 3 : 1,
                      color: selectedOption == 0 ? Colors.orange : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedOption = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.textMiddle,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: selectedOption == 1
                                ? Colors.orange
                                : Colors.white,
                          ),
                    ),
                    Container(
                      height: selectedOption == 1 ? 3 : 1,
                      color: selectedOption == 1 ? Colors.orange : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedOption = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.textRight,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: selectedOption == 2
                                ? Colors.orange
                                : Colors.white,
                          ),
                    ),
                    Container(
                      height: selectedOption == 2 ? 3 : 1,
                      color: selectedOption == 2 ? Colors.orange : Colors.white,
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