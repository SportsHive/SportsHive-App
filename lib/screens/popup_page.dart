import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';
import 'package:sportshive/screens/welcome_screen.dart';

class PopupHelper {
  static void showSignOutPopup(BuildContext context, String popupType) {
    switch (popupType) {
      case 'POP_SignOut':
        AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Warning",
            desc: "Are you sure you want to sign out?",
            //actions to perform on cancels and ok button
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              AuthenticationRepository.instance.logOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            }).show();
        break;
      default:
        break;
    }
  }

  static void showSuccessfulLoginPopup(BuildContext context, String popupType) {
    switch (popupType) {
      case 'POP_SUCCESSFUL':
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            showCloseIcon: true,
            title: 'Congratulations! ',
            desc: 'You customized your account successfully!')
          ..show();
        break;
      default:
        break;
    }
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('My App'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    ),
  );
}
