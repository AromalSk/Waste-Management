// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class Message {
  String userId;
  String text;
  DateTime dateTime; // Changed type to DateTime
  bool isSentByMe;
  String name;
  Message({
    required this.userId,
    required this.text,
    required this.dateTime,
    required this.isSentByMe,
    required this.name,
  });

  Message copyWith({
    String? userId,
    String? text,
    DateTime? dateTime,
    bool? isSentByMe,
    String? name,
  }) {
    return Message(
      userId: userId ?? this.userId,
      text: text ?? this.text,
      dateTime: dateTime ?? this.dateTime,
      isSentByMe: isSentByMe ?? this.isSentByMe,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'text': text,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isSentByMe': isSentByMe,
      'name': name,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      userId: map['userId'] as String,
      text: map['text'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      isSentByMe: map['isSentByMe'] as bool,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(userId: $userId, text: $text, dateTime: $dateTime, isSentByMe: $isSentByMe, name: $name)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.text == text &&
        other.dateTime == dateTime &&
        other.isSentByMe == isSentByMe &&
        other.name == name;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        text.hashCode ^
        dateTime.hashCode ^
        isSentByMe.hashCode ^
        name.hashCode;
  }
}
