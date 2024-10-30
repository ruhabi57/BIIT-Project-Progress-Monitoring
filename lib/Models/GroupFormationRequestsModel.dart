import 'dart:convert';

class GroupFormationRequest {
  int? group_id;
  int student_id;
  String senderName;
  int request_id;
  int user_id;
  String technology_preference;
  bool isAccepted;
  GroupFormationRequest({
    this.group_id,
    required this.student_id,
    required this.senderName,
    required this.request_id,
    required this.user_id,
    required this.technology_preference,
    required this.isAccepted,
  });

  GroupFormationRequest copyWith({
    int? group_id,
    int? student_id,
    String? senderName,
    int? request_id,
    int? user_id,
    String? technology_preference,
    bool? isAccepted,
  }) {
    return GroupFormationRequest(
      group_id: group_id ?? this.group_id,
      student_id: student_id ?? this.student_id,
      senderName: senderName ?? this.senderName,
      request_id: request_id ?? this.request_id,
      user_id: user_id ?? this.user_id,
      technology_preference:
          technology_preference ?? this.technology_preference,
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (group_id != null) {
      result.addAll({'group_id': group_id});
    }
    result.addAll({'student_id': student_id});
    result.addAll({'senderName': senderName});
    result.addAll({'request_id': request_id});
    result.addAll({'user_id': user_id});
    result.addAll({'technology_preference': technology_preference});
    result.addAll({'isAccepted': isAccepted});

    return result;
  }

  factory GroupFormationRequest.fromMap(Map<String, dynamic> map) {
    return GroupFormationRequest(
      group_id: map['group_id']?.toInt(),
      student_id: map['student_id']?.toInt() ?? 0,
      senderName: map['senderName'] ?? '',
      request_id: map['request_id']?.toInt() ?? 0,
      user_id: map['user_id']?.toInt() ?? 0,
      technology_preference: map['technology_preference'] ?? '',
      isAccepted: map['isAccepted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupFormationRequest.fromJson(String source) =>
      GroupFormationRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupFormationRequest(group_id: $group_id, student_id: $student_id, senderName: $senderName, request_id: $request_id, user_id: $user_id, technology_preference: $technology_preference, isAccepted: $isAccepted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupFormationRequest &&
        other.group_id == group_id &&
        other.student_id == student_id &&
        other.senderName == senderName &&
        other.request_id == request_id &&
        other.user_id == user_id &&
        other.technology_preference == technology_preference &&
        other.isAccepted == isAccepted;
  }

  @override
  int get hashCode {
    return group_id.hashCode ^
        student_id.hashCode ^
        senderName.hashCode ^
        request_id.hashCode ^
        user_id.hashCode ^
        technology_preference.hashCode ^
        isAccepted.hashCode;
  }
}
