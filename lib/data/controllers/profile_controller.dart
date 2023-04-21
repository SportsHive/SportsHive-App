

import 'package:get/get.dart';
import 'package:sportshive/data/controllers/sign_up_controllers.dart';
import 'package:sportshive/data/repositories/auth_repo.dart';
import 'package:sportshive/data/repositories/user_repo.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final userRepo = Get.put(UserRepository());

  Future<List<UserModel>> getAllUsers() async {
    return await userRepo.getUsers();
  }

}