import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class FullBinImages {
  String imagePath;
  String userLocation;
  bool status;
  DateTime dateTime;
  String imageListId;
  String gender;
  String userId;
  String latitude;
  String longitude;
  FullBinImages({
    required this.imagePath,
    required this.userLocation,
    required this.status,
    required this.dateTime,
    required this.imageListId,
    required this.gender,
    required this.userId,
    required this.latitude,
    required this.longitude,
  });

  FullBinImages copyWith({
    String? imagePath,
    String? userLocation,
    bool? status,
    DateTime? dateTime,
    String? imageListId,
    String? gender,
    String? userId,
    String? latitude,
    String? longitude,
  }) {
    return FullBinImages(
      imagePath: imagePath ?? this.imagePath,
      userLocation: userLocation ?? this.userLocation,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      imageListId: imageListId ?? this.imageListId,
      gender: gender ?? this.gender,
      userId: userId ?? this.userId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'userLocation': userLocation,
      'status': status,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'imageListId': imageListId,
      'gender': gender,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory FullBinImages.fromMap(Map<String, dynamic> map) {
    return FullBinImages(
      imagePath: map['imagePath'] as String,
      userLocation: map['userLocation'] as String,
      status: map['status'] as bool,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      imageListId: map['imageListId'] as String,
      gender: map['gender'] as String,
      userId: map['userId'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FullBinImages.fromJson(String source) =>
      FullBinImages.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FullBinImages(imagePath: $imagePath, userLocation: $userLocation, status: $status, dateTime: $dateTime, imageListId: $imageListId, gender: $gender, userId: $userId, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant FullBinImages other) {
    if (identical(this, other)) return true;
  
    return 
      other.imagePath == imagePath &&
      other.userLocation == userLocation &&
      other.status == status &&
      other.dateTime == dateTime &&
      other.imageListId == imageListId &&
      other.gender == gender &&
      other.userId == userId &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
      userLocation.hashCode ^
      status.hashCode ^
      dateTime.hashCode ^
      imageListId.hashCode ^
      gender.hashCode ^
      userId.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
  }
}
