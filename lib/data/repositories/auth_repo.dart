
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sportshive/data/repositories/sing_up_failures.dart';
import 'package:sportshive/screens/auth/event_page.dart';
import 'package:sportshive/screens/auth/preference_screen.dart';
import 'package:sportshive/screens/auth/profile_screen.dart';
import 'package:sportshive/screens/auth/welcome_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final auth = FirebaseAuth.instance;
  static bool IsLoggedIn = false;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 3));
    firebaseUser =  Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user){
    user == null? Get.offAll(() => const WelcomeScreen()) : Get.offAll(
      () => ProfileScreen()
    );
  }

  void createUserWithEmailAndPassword(String email, String pass) async {
    try {
    await auth.createUserWithEmailAndPassword(email: email, password: pass);
    firebaseUser.value != null ? Get.offAll(() => SportsPreferenceScreen()) : Get.to(const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
        final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
        print('FIREBASE AUTH EXCEPTION - ${ex.message}');
        throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email, String pass) async {
    IsLoggedIn = true;
    try {
    await auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print('LOGIN ERROR');
    } 
  }

  //function to log out users
  Future<void> logOut() async{
    IsLoggedIn = !IsLoggedIn;
    return await auth.signOut();
  }

}