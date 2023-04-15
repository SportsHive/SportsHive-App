import 'package:flutter/material.dart';
import 'package:sportshive/componnets/background.dart';
import 'package:sportshive/screens/auth/welcome_screen.dart';
import 'package:sportshive/widgets/text_field_input.dart';
import 'package:sportshive/screens/auth/profile_pic.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sportshive/screens/auth/preference_screen.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tell us more about yourself'),
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Background(
        child: Column(
          children: [
            const SizedBox(height: 70),
            ProfilePic(),
            const SizedBox(height: 40),
            TextFieldInput(
              textEditingController: _firstNameController,
              hintText: 'First Name',
              textInputType: TextInputType.name,
              prefixIcon: Icons.person,
              borderColor: Color.fromARGB(255, 255, 255, 255),
              borderWidth: 2.0,
              borderRadius: 15.0,
            ),
            const SizedBox(height: 24),
            TextFieldInput(
              textEditingController: _lastNameController,
              hintText: 'Last Name',
              textInputType: TextInputType.name,
              prefixIcon: Icons.person,
              borderColor: Colors.white,
              borderWidth: 2.0,
              borderRadius: 15.0,
            ),
            const SizedBox(height: 24),
            TextFieldInput(
              textEditingController: _phoneController,
              hintText: 'Phone Number',
              textInputType: TextInputType.phone,
              prefixIcon: Icons.phone,
              borderColor: Colors.white,
              borderWidth: 2.0,
              borderRadius: 15.0,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    _countryController.text = country.displayNameNoCountryCode;
                  },
                );
              },
              child: SizedBox(
                width: 366,
                child: TextFormField(
                  enabled: false,
                  controller: _countryController,
                  style: TextStyle(),
                  decoration: InputDecoration(
                    hintText: 'Country',
                    prefixIcon: Icon(Icons.flag),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFieldInput(
              textEditingController: _bioController,
              hintText: 'About',
              textInputType: TextInputType.multiline,
              prefixIcon: Icons.info,
              borderColor: Colors.white,
              borderWidth: 2.0,
              borderRadius: 15.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onDonePressed,
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _onDonePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SportsPreferenceScreen()),
    );
  }
}

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.isPass = false,
    required this.prefixIcon,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  final IconData prefixIcon;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isPass,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
      ),
    );
  }
}
