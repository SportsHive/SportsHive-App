

class UserModel 
{
  final String? id;
  final String username;
  final String fname;
  final String lname;
  final String email;
  final String address;
  final String nationality;
  final String DoB;
  final int followers;
  final int following;
  final String avatar;
  final String desc;
  final String phone;

  const UserModel({
    this.id,
    required this.email,
    required this.username,
    required this.fname,
    required this.lname,
    required this.address,
    required this.nationality,
    required this.DoB,
    required this.followers,
    required this.following,
    required this.avatar,
    required this.desc,
    required this.phone
  });

  toJson(){
    return {
    "email": email,
    "username":  username,
     "first_name": fname,
    "last_name": lname,
    "address": address,
    "nationality": nationality,
    "DoB": DoB,
    "followers_count": followers,
    "follows_count": following,
    "avatar_url": avatar,
    "description": desc,
    "phone_number": phone
    };
  }
}