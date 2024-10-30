import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Models/Supervisor.dart';
import 'package:collection/collection.dart';

class Student {
  final String student_name;
  final String arid_no;
  final int semester;
  String platform;
  int? user_id;
  final int student_id;
  Student({
    required this.student_name,
    required this.arid_no,
    required this.semester,
    required this.platform,
    this.user_id,
    required this.student_id,
  });

  Student copyWith({
    String? student_name,
    String? arid_no,
    int? semester,
    String? platform,
    int? user_id,
    int? student_id,
  }) {
    return Student(
      student_name: student_name ?? this.student_name,
      arid_no: arid_no ?? this.arid_no,
      semester: semester ?? this.semester,
      platform: platform ?? this.platform,
      user_id: user_id ?? this.user_id,
      student_id: student_id ?? this.student_id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'student_name': student_name});
    result.addAll({'arid_no': arid_no});
    result.addAll({'semester': semester});
    result.addAll({'platform': platform});
    if (user_id != null) {
      result.addAll({'user_id': user_id});
    }
    result.addAll({'student_id': student_id});

    return result;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      student_name: map['student_name'] ?? '',
      arid_no: map['arid_no'] ?? '',
      semester: map['semester']?.toInt() ?? 0,
      platform: map['platform'] ?? '',
      user_id: map['user_id']?.toInt(),
      student_id: map['student_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(student_name: $student_name, arid_no: $arid_no, semester: $semester, platform: $platform, user_id: $user_id, student_id: $student_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.student_name == student_name &&
        other.arid_no == arid_no &&
        other.semester == semester &&
        other.platform == platform &&
        other.user_id == user_id &&
        other.student_id == student_id;
  }

  @override
  int get hashCode {
    return student_name.hashCode ^
        arid_no.hashCode ^
        semester.hashCode ^
        platform.hashCode ^
        user_id.hashCode ^
        student_id.hashCode;
  }
}

class Member {
  final String username;
  final String platform;
  final String role;
  final Student student;
  final int group_id;
  Member({
    required this.username,
    required this.platform,
    required this.role,
    required this.student,
    required this.group_id,
  });

  Member copyWith({
    String? username,
    String? platform,
    String? role,
    Student? student,
    int? group_id,
  }) {
    return Member(
      username: username ?? this.username,
      platform: platform ?? this.platform,
      role: role ?? this.role,
      student: student ?? this.student,
      group_id: group_id ?? this.group_id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'platform': platform});
    result.addAll({'role': role});
    result.addAll({'student': student.toMap()});
    result.addAll({'group_id': group_id});

    return result;
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      username: map['username'] ?? '',
      platform: map['platform'] ?? '',
      role: map['role'] ?? '',
      student: Student.fromMap(map['student']),
      group_id: map['group_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Member(username: $username, platform: $platform, role: $role, student: $student, group_id: $group_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Member &&
        other.username == username &&
        other.platform == platform &&
        other.role == role &&
        other.student == student &&
        other.group_id == group_id;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        platform.hashCode ^
        role.hashCode ^
        student.hashCode ^
        group_id.hashCode;
  }
}

class Projects {
  int? project_id;
  String project_status;
  String project_title;
  String name;
  int supervisor_id;
  String fyp_type;
  SupervisorModel? supervisor;
  List<Student> student;
  List<Member> members;

  Projects({
    this.project_id,
    required this.project_status,
    required this.project_title,
    required this.name,
    required this.supervisor_id,
    required this.fyp_type,
    this.supervisor,
    required this.student,
    required this.members,
  });

  factory Projects.fromMap(Map<String, dynamic> map) {
    return Projects(
      project_id: map['project_id']?.toInt(),
      project_status: map['project_status'] ?? '',
      project_title: map['project_title'] ?? '',
      name: map['name'] ?? '',
      supervisor_id: map['supervisor_id']?.toInt() ?? 0,
      fyp_type: map['fyp_type'] ?? '',
      supervisor: map['supervisor'] != null
          ? SupervisorModel.fromMap(map['supervisor'])
          : null,
      student: map['student'] != null
          ? List<Student>.from(map['student'].map((x) => Student.fromMap(x)))
          : [],
      members: map['members'] != null
          ? List<Member>.from(map['members'].map((x) => Member.fromMap(x)))
          : [],
    );
  }

  Projects copyWith({
    int? project_id,
    String? project_status,
    String? project_title,
    String? name,
    int? supervisor_id,
    String? fyp_type,
    SupervisorModel? supervisor,
    List<Student>? student,
    List<Member>? members,
  }) {
    return Projects(
      project_id: project_id ?? this.project_id,
      project_status: project_status ?? this.project_status,
      project_title: project_title ?? this.project_title,
      name: name ?? this.name,
      supervisor_id: supervisor_id ?? this.supervisor_id,
      fyp_type: fyp_type ?? this.fyp_type,
      supervisor: supervisor ?? this.supervisor,
      student: student ?? this.student,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (project_id != null) {
      result.addAll({'project_id': project_id});
    }
    result.addAll({'project_status': project_status});
    result.addAll({'project_title': project_title});
    result.addAll({'name': name});
    result.addAll({'supervisor_id': supervisor_id});
    result.addAll({'fyp_type': fyp_type});
    if (supervisor != null) {
      result.addAll({'supervisor': supervisor!.toMap()});
    }
    result.addAll({'student': student.map((x) => x.toMap()).toList()});
    result.addAll({'members': members.map((x) => x.toMap()).toList()});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory Projects.fromJson(String source) =>
      Projects.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Projects(project_id: $project_id, project_status: $project_status, project_title: $project_title, name: $name, supervisor_id: $supervisor_id, fyp_type: $fyp_type, supervisor: $supervisor, student: $student, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Projects &&
        other.project_id == project_id &&
        other.project_status == project_status &&
        other.project_title == project_title &&
        other.name == name &&
        other.supervisor_id == supervisor_id &&
        other.fyp_type == fyp_type &&
        other.supervisor == supervisor &&
        listEquals(other.student, student) &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return project_id.hashCode ^
        project_status.hashCode ^
        project_title.hashCode ^
        name.hashCode ^
        supervisor_id.hashCode ^
        fyp_type.hashCode ^
        supervisor.hashCode ^
        student.hashCode ^
        members.hashCode;
  }
}
