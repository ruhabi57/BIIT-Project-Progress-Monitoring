import 'dart:convert';

class GetGradedStudent {
  String C;
  String student_name;
  String arid_no;
  String project_title;
  GetGradedStudent({
    required this.C,
    required this.student_name,
    required this.arid_no,
    required this.project_title,
  });

  GetGradedStudent copyWith({
    String? C,
    String? student_name,
    String? arid_no,
    String? project_title,
  }) {
    return GetGradedStudent(
      C: C ?? this.C,
      student_name: student_name ?? this.student_name,
      arid_no: arid_no ?? this.arid_no,
      project_title: project_title ?? this.project_title,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'C': C});
    result.addAll({'student_name': student_name});
    result.addAll({'arid_no': arid_no});
    result.addAll({'project_title': project_title});

    return result;
  }

  factory GetGradedStudent.fromMap(Map<String, dynamic> map) {
    return GetGradedStudent(
      C: map['C'] ?? '',
      student_name: map['student_name'] ?? '',
      arid_no: map['arid_no'] ?? '',
      project_title: map['project_title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GetGradedStudent.fromJson(String source) =>
      GetGradedStudent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetGradedStudent(C: $C, student_name: $student_name, arid_no: $arid_no, project_title: $project_title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetGradedStudent &&
        other.C == C &&
        other.student_name == student_name &&
        other.arid_no == arid_no &&
        other.project_title == project_title;
  }

  @override
  int get hashCode {
    return C.hashCode ^
        student_name.hashCode ^
        arid_no.hashCode ^
        project_title.hashCode;
  }
}
