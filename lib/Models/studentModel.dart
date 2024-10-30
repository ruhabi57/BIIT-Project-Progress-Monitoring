import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Models/GetGroupDetailModel.dart';

class Student {
  int? student_id;
  String student_name;
  String arid_no;
  int semester;
  double cgpa;
  String? platform;
  Student({
    this.student_id,
    required this.student_name,
    required this.arid_no,
    required this.semester,
    required this.cgpa,
    this.platform,
  });

  Student copyWith({
    int? student_id,
    String? student_name,
    String? arid_no,
    int? semester,
    double? cgpa,
    String? platform,
  }) {
    return Student(
      student_id: student_id ?? this.student_id,
      student_name: student_name ?? this.student_name,
      arid_no: arid_no ?? this.arid_no,
      semester: semester ?? this.semester,
      cgpa: cgpa ?? this.cgpa,
      platform: platform ?? this.platform,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (student_id != null) {
      result.addAll({'student_id': student_id});
    }
    result.addAll({'student_name': student_name});
    result.addAll({'arid_no': arid_no});
    result.addAll({'semester': semester});
    result.addAll({'cgpa': cgpa});
    if (platform != null) {
      result.addAll({'platform': platform});
    }

    return result;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      student_id: map['student_id']?.toInt(),
      student_name: map['student_name'] ?? '',
      arid_no: map['arid_no'] ?? '',
      semester: map['semester']?.toInt() ?? 0,
      cgpa: map['cgpa']?.toDouble() ?? 0.0,
      platform: map['platform'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(student_id: $student_id, student_name: $student_name, arid_no: $arid_no, semester: $semester, cgpa: $cgpa, platform: $platform)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.student_id == student_id &&
        other.student_name == student_name &&
        other.arid_no == arid_no &&
        other.semester == semester &&
        other.cgpa == cgpa &&
        other.platform == platform;
  }

  @override
  int get hashCode {
    return student_id.hashCode ^
        student_name.hashCode ^
        arid_no.hashCode ^
        semester.hashCode ^
        cgpa.hashCode ^
        platform.hashCode;
  }
}
