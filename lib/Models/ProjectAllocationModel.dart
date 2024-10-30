import 'dart:convert';

import 'package:collection/collection.dart';

class GetAllGroupsToAssign {
  int? group_id;
  List<StudentProjectNotAssigned>? Students;
  GetAllGroupsToAssign({
    this.group_id,
    this.Students,
  });

  GetAllGroupsToAssign copyWith({
    int? group_id,
    List<StudentProjectNotAssigned>? Students,
  }) {
    return GetAllGroupsToAssign(
      group_id: group_id ?? this.group_id,
      Students: Students ?? this.Students,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (group_id != null) {
      result.addAll({'group_id': group_id});
    }
    if (Students != null) {
      result.addAll({'Students': Students!.map((x) => x?.toMap()).toList()});
    }

    return result;
  }

  factory GetAllGroupsToAssign.fromMap(Map<String, dynamic> map) {
    return GetAllGroupsToAssign(
      group_id: map['group_id']?.toInt(),
      Students: map['Students'] != null
          ? List<StudentProjectNotAssigned>.from(
              map['Students']?.map((x) => StudentProjectNotAssigned.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllGroupsToAssign.fromJson(String source) =>
      GetAllGroupsToAssign.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllGroupsToAssign(group_id: $group_id, Students: $Students)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GetAllGroupsToAssign &&
        other.group_id == group_id &&
        listEquals(other.Students, Students);
  }

  @override
  int get hashCode => group_id.hashCode ^ Students.hashCode;
}

class StudentProjectNotAssigned {
  String? student_name;
  String? arid_no;
  double? cgpa;
  String? platform;
  int? semester;
  StudentProjectNotAssigned({
    this.student_name,
    this.arid_no,
    this.cgpa,
    this.platform,
    this.semester,
  });

  StudentProjectNotAssigned copyWith({
    String? student_name,
    String? arid_no,
    double? cgpa,
    String? platform,
    int? semester,
  }) {
    return StudentProjectNotAssigned(
      student_name: student_name ?? this.student_name,
      arid_no: arid_no ?? this.arid_no,
      cgpa: cgpa ?? this.cgpa,
      platform: platform ?? this.platform,
      semester: semester ?? this.semester,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (student_name != null) {
      result.addAll({'student_name': student_name});
    }
    if (arid_no != null) {
      result.addAll({'arid_no': arid_no});
    }
    if (cgpa != null) {
      result.addAll({'cgpa': cgpa});
    }
    if (platform != null) {
      result.addAll({'platform': platform});
    }
    if (semester != null) {
      result.addAll({'semester': semester});
    }

    return result;
  }

  factory StudentProjectNotAssigned.fromMap(Map<String, dynamic> map) {
    return StudentProjectNotAssigned(
      student_name: map['student_name'],
      arid_no: map['arid_no'],
      cgpa: map['cgpa']?.toDouble(),
      platform: map['platform'],
      semester: map['semester']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentProjectNotAssigned.fromJson(String source) =>
      StudentProjectNotAssigned.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentProjectNotAssigned(student_name: $student_name, arid_no: $arid_no, cgpa: $cgpa, platform: $platform, semester: $semester)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentProjectNotAssigned &&
        other.student_name == student_name &&
        other.arid_no == arid_no &&
        other.cgpa == cgpa &&
        other.platform == platform &&
        other.semester == semester;
  }

  @override
  int get hashCode {
    return student_name.hashCode ^
        arid_no.hashCode ^
        cgpa.hashCode ^
        platform.hashCode ^
        semester.hashCode;
  }
}
