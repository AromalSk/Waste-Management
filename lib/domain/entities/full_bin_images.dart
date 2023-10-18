import 'dart:convert';


// ignore_for_file: public_member_api_docs, sort_constructors_first

class FullBinImages {
  String imagePath;
  String userLocation;
  bool status;
  DateTime dateTime;
  String userId;
  FullBinImages({
    required this.imagePath,
    required this.userLocation,
    required this.status,
    required this.dateTime,
    required this.userId,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'userLocation': userLocation,
      'status': status,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'userId': userId,
    };
  }

  factory FullBinImages.fromMap(Map<String, dynamic> map) {
    return FullBinImages(
      imagePath: map['imagePath'] as String,
      userLocation: map['userLocation'] as String,
      status: map['status'] as bool,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FullBinImages.fromJson(String source) => FullBinImages.fromMap(json.decode(source) as Map<String, dynamic>);
}
