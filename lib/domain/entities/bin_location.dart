// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BinLocationModel {
  String streetLocation;
  num latitude;
  num longitude;
  BinLocationModel({
    required this.streetLocation,
    required this.latitude,
    required this.longitude,
  });

  BinLocationModel copyWith({
    String? streetLocation,
    num? latitude,
    num? longitude,
  }) {
    return BinLocationModel(
      streetLocation: streetLocation ?? this.streetLocation,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'streetLocation': streetLocation,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory BinLocationModel.fromMap(Map<String, dynamic> map) {
    return BinLocationModel(
      streetLocation: map['streetLocation'] as String,
      latitude: map['latitude'] as num,
      longitude: map['longitude'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory BinLocationModel.fromJson(String source) =>
      BinLocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BinLocationModel(streetLocation: $streetLocation, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant BinLocationModel other) {
    if (identical(this, other)) return true;

    return other.streetLocation == streetLocation &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode =>
      streetLocation.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
