

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String email;
  final String password;
  final String? fname;
  final String? lname;
  final String? address;
  final String? nationality;
  final String? dob;
  final int? followers;
  final int? following;
  final String? avatar;
  final String? desc;
  final String? phone;
  

  const UserModel({
    this.id,
    required this.email,
    required this.username,
    required this.password,
    this.fname,
    this.lname,
    this.address,
    this.nationality,
    this.dob,
    this.followers,
    this.following,
    this.avatar,
    this.desc,
    this.phone,
    
  });

  toJson(){
    return {
    "email": email,
    "username":  username,
    "password": password,  
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data();
    return UserModel(
      id: document.id,
      email: data!["email"],
      username: data["username"],
      password: data["password"]
      );
  }
}