import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:sportshive/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen ({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();

}

class _SignUpState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _userController.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding : const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
         
              Flexible(child: Container(), flex: 2,),
                   //svg image
              SvgPicture.asset(
                'assets/login_logo.svg', 
               height: 140,
               ),
               const SizedBox(height: 25),
              //textfield for username
                  TextFieldInput(
                textEditingController:  _userController, 
                hintText: 'Create a username',
                 textInputType: TextInputType.text
                 ),
                 const SizedBox(
                height: 24
                ),
              //textfield for email
              TextFieldInput(
                textEditingController:  _emailController, 
                hintText: 'Enter your email',
                 textInputType: TextInputType.emailAddress
                 ),
              //textfeild for password
              const SizedBox(
                height: 24
                ),
                 TextFieldInput(
                textEditingController:  _passController, 
                hintText: 'Enter your password',
                 textInputType: TextInputType.text,
                 isPass: true,
                 ),
              //button for login
              const SizedBox(
                height: 24
                ),
              InkWell(
                child: Container(
                  child: const Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4),
                      
                      ),
                    ),
                    
                    color: orange
                  ),
                ),
              ),
              
              const SizedBox(
                height: 12
                ),
              Flexible(child: Container(), flex: 2,),
              //Transition to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Dont Have an Account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Text(
                        "Sign Up!",
                       style: TextStyle(
                       fontWeight: FontWeight.bold)),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  ),

                ],
              )
            
            ],

          ),
          ),
      ),
    );
  }

}
