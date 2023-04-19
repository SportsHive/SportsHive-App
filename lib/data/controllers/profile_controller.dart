

import 'package:get/get.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';
import 'package:sportshive/data/repositories/user_repo.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final authRepo = Get.put(AuthenticationRepository());
  final userRepo = Get.put(UserRepository());

  getUserData() {
    final email = authRepo.firebaseUser.value?.email;
    if (email != null){
      return userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    return await userRepo.getUsers();

  }
}