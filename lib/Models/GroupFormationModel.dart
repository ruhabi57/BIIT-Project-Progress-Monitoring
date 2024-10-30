import 'dart:convert';

class GroupFormationModel {
  int user_id;
  String technology;
  int student_id;
  GroupFormationModel({
    required this.user_id,
    required this.technology,
    required this.student_id,
  });

  GroupFormationModel copyWith({
    int? user_id,
    String? technology,
    int? student_id,
  }) {
    return GroupFormationModel(
      user_id: user_id ?? this.user_id,
      technology: technology ?? this.technology,
      student_id: student_id ?? this.student_id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_id': user_id});
    result.addAll({'technology': technology});
    result.addAll({'student_id': student_id});

    return result;
  }

  factory GroupFormationModel.fromMap(Map<String, dynamic> map) {
    return GroupFormationModel(
      user_id: map['user_id']?.toInt() ?? 0,
      technology: map['technology'] ?? '',
      student_id: map['student_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupFormationModel.fromJson(String source) =>
      GroupFormationModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'GroupFormationModel(user_id: $user_id, technology: $technology, student_id: $student_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupFormationModel &&
        other.user_id == user_id &&
        other.technology == technology &&
        other.student_id == student_id;
  }

  @override
  int get hashCode =>
      user_id.hashCode ^ technology.hashCode ^ student_id.hashCode;
}
