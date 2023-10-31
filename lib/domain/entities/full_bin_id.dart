// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FullBinId {
  String userId;
  String gender;
  String userLocation;
  bool status;
  FullBinId({
    required this.userId,
    required this.gender,
    required this.userLocation,
    required this.status,
  });

  FullBinId copyWith({
    String? userId,
    String? gender,
    String? userLocation,
    bool? status,
  }) {
    return FullBinId(
      userId: userId ?? this.userId,
      gender: gender ?? this.gender,
      userLocation: userLocation ?? this.userLocation,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'gender': gender,
      'userLocation': userLocation,
      'status': status,
    };
  }

  factory FullBinId.fromMap(Map<String, dynamic> map) {
    return FullBinId(
      userId: map['userId'] as String,
      gender: map['gender'] as String,
      userLocation: map['userLocation'] as String,
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FullBinId.fromJson(String source) => FullBinId.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FullBinId(userId: $userId, gender: $gender, userLocation: $userLocation, status: $status)';
  }

  @override
  bool operator ==(covariant FullBinId other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.gender == gender &&
      other.userLocation == userLocation &&
      other.status == status;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      gender.hashCode ^
      userLocation.hashCode ^
      status.hashCode;
  }
}
