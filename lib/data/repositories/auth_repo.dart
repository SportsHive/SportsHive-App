import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sportshive/data/repositories/sing_up_failures.dart';
import 'package:sportshive/screens/auth/event_page.dart';
import 'package:sportshive/screens/auth/welcome_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  void onReady() {
    Future.delayed(const Duration(seconds: 3));
    firebaseUser =  Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user){
    user == null? Get.offAll(() => EventsScreen()) : Get.offAll(
      () => EventsScreen()
    );
  }

  void createUserWithEmailAndPassword(String email, String pass) async {
    try {
    await auth.createUserWithEmailAndPassword(email: email, password: pass);
    firebaseUser.value != null ? Get.offAll(() => EventsScreen()) : Get.to(WelcomeScreen());
    } on FirebaseAuthException catch (e) {
        final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
        print('FIREBASE AUTH EXCEPTION - ${ex.message}');
        throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email, String pass) async {
    try {
    await auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {

    } 
  }

  Future<void> logOut() async => await auth.signOut(); 
}