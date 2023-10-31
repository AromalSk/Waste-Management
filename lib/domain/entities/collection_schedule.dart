// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CollectionSchedule {
  String? days;
  String? type;

  CollectionSchedule({
    this.days,
    this.type,
  });

  CollectionSchedule copyWith({
    String? days,
    String? type,
  }) {
    return CollectionSchedule(
      days: days ?? this.days,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'days': days,
      'type': type,
    };
  }

  factory CollectionSchedule.fromMap(Map<String, dynamic> map) {
    return CollectionSchedule(
      days: map['days'] != null ? map['days'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionSchedule.fromJson(String source) => CollectionSchedule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CollectionSchedule(days: $days, type: $type)';

  @override
  bool operator ==(covariant CollectionSchedule other) {
    if (identical(this, other)) return true;
  
    return 
      other.days == days &&
      other.type == type;
  }

  @override
  int get hashCode => days.hashCode ^ type.hashCode;
}
