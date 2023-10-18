// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDetails {
  
  String? userId;
  String? userName;
  String? email;
  String? phonenumber;
  String? birthdate;
  String? address;
  String? gender;
  DateTime? dateTime;
  
  UserDetails({
    this.userId,
    this.userName,
    this.email,
    this.phonenumber,
    this.birthdate,
    this.address,
    this.gender,
    this.dateTime,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'email': email,
      'phonenumber': phonenumber,
      'birthdate': birthdate,
      'address': address,
      'gender': gender,
      'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phonenumber: map['phonenumber'] != null ? map['phonenumber'] as String : null,
      birthdate: map['birthdate'] != null ? map['birthdate'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      dateTime: map['dateTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) => UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
