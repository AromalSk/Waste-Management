import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeeklyCollection {
  String location;
  String latitude;
  String longitude;
  String amount;
  String userId;
  DateTime dateTime;
  String type;
  bool status;
  String gender;
  WeeklyCollection({
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.amount,
    required this.userId,
    required this.dateTime,
    required this.type,
    required this.status,
    required this.gender,
  });
 

  WeeklyCollection copyWith({
    String? location,
    String? latitude,
    String? longitude,
    String? amount,
    String? userId,
    DateTime? dateTime,
    String? type,
    bool? status,
    String? gender,
  }) {
    return WeeklyCollection(
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      amount: amount ?? this.amount,
      userId: userId ?? this.userId,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      status: status ?? this.status,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'amount': amount,
      'userId': userId,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'type': type,
      'status': status,
      'gender': gender,
    };
  }

  factory WeeklyCollection.fromMap(Map<String, dynamic> map) {
    return WeeklyCollection(
      location: map['location'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      amount: map['amount'] as String,
      userId: map['userId'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      type: map['type'] as String,
      status: map['status'] as bool,
      gender: map['gender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeeklyCollection.fromJson(String source) => WeeklyCollection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeeklyCollection(location: $location, latitude: $latitude, longitude: $longitude, amount: $amount, userId: $userId, dateTime: $dateTime, type: $type, status: $status, gender: $gender)';
  }

  @override
  bool operator ==(covariant WeeklyCollection other) {
    if (identical(this, other)) return true;
  
    return 
      other.location == location &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.amount == amount &&
      other.userId == userId &&
      other.dateTime == dateTime &&
      other.type == type &&
      other.status == status &&
      other.gender == gender;
  }

  @override
  int get hashCode {
    return location.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      amount.hashCode ^
      userId.hashCode ^
      dateTime.hashCode ^
      type.hashCode ^
      status.hashCode ^
      gender.hashCode;
  }
}
