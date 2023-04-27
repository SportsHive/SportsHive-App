import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportshive/screens/editprofile_page.dart';
import 'package:sportshive/screens/login_page.dart';
import 'package:sportshive/screens/popup_page.dart';
import 'package:sportshive/screens/search_screen.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportshive/utils/global_variables.dart';
import '../screens/welcome_screen.dart';

//for popups
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:sportshive/screens/popup_page.dart';

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
    pageController = PageController(initialPage: 3);
    _page = 3;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              "Sports",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const Text(
              "Hive",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: orange,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Add code here for the search button
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: orange, // Set the background color
                onPrimary: Colors.white, // Set the text color
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(width: 5.0),
        ],
      ),
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_rounded,
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
              Icons.add_circle,
              color: (_page == 2) ? orange : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 3) ? orange : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: (int index) {
          setState(() {
            _page = index;
            if (index == 3) {
              if (FirebaseAuth.instance.currentUser == null) {
                desiredProfileUsername = "";
              } else {
                desiredProfileUsername =
                    FirebaseAuth.instance.currentUser!.displayName ?? "";
              }
            }
            navigationTapped(
                index); // Call the function with the index argument
          });
        },
      ),
    );
  }
}

bool isLoggedIn() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return _auth.currentUser != null;
}
