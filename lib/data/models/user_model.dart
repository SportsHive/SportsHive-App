import 'package:cloud_firestore/cloud_firestore.dart';

//email, username and password are available on registration

class UserModel {

  //attributes
  String? id;
  String username;
  String email;
  String password;
  int? followers;
  int? following;
  String? avatar;
  String? fname;
  String? lname;
  String? address;
  String? nationality;
  String? dob;
  String? desc;
  String? phone;
  List<String>? awards;
  List<String>? sports;
  List<String>? posts;
  int? height;
  int? weight;
  

   UserModel({
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
    this.sports,
    this.posts
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
      "sports": sports,
      "posts": posts,
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
      height: data["height"],
      sports: data["sports"],
      posts: data["posts"],
      );
  }
}