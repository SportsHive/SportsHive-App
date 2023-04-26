

import 'package:cloud_firestore/cloud_firestore.dart';


//email, username and password are available on registration

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
  final List<String>? awards;
  final int? height;
  final int? weight;
  

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
    this.awards,
    this.height,
    this.weight,
  });


  Map<String, dynamic> toJson(){
    return {
      "email": email,
      "username":  username,
      "password": password,  
      "first_name": fname,
      "last_name": lname,
      "address": address,
      "nationality": nationality,
      "dob": dob,
      "followers_count": followers,
      "follows-count": following,
      "avatar_url": avatar,
      "description": desc,
      "phone": phone,
      "awards": awards,
      "height": height,
      "weight": weight,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data();
    return UserModel(
      id: document.id,
      email: data!["email"],
      username: data["username"],
      password: data["password"],
      fname: data["first_name"],
      lname: data["last_name"],
      address: data["address"],
      nationality: data["nationality"],
      dob: data["dob"],
      followers: data["followers_count"],
      following: data["follows-count"],
      avatar: data["avatar_url"] ,
      desc: data["description"],
      phone: data["phone"],
      awards: data["awards"],
      weight: data["weight"],
      height: data["height"]
      );
  }
}