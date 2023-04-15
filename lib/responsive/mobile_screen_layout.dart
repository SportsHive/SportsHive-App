import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportshive/utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Text("events"),
          Text("home"),
          Text("profile"),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: (_page == 0) ? orange : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 1) ? orange : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 2) ? orange : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
