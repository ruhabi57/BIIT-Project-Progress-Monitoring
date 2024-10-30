import 'dart:convert';

import 'package:collection/collection.dart';

class GroupDetail {
  List<Members>? members;
  Group? group;
  ProjectDetail? projectdetail;
  GroupDetail({
    this.members,
    this.group,
    required this.projectdetail,
  });

  GroupDetail copyWith({
    List<Members>? members,
    Group? group,
    ProjectDetail? projectdetail,
  }) {
    return GroupDetail(
      members: members ?? this.members,
      group: group ?? this.group,
      projectdetail: projectdetail ?? this.projectdetail,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (members != null) {
      result.addAll({'members': members!.map((x) => x?.toMap()).toList()});
    }
    if (group != null) {
      result.addAll({'group': group!.toMap()});
    }
    if (projectdetail != null) {
      result.addAll({'projectdetail': projectdetail!.toMap()});
    }

    return result;
  }

  factory GroupDetail.fromMap(Map<String, dynamic> map) {
    return GroupDetail(
      members: map['members'] != null
          ? List<Members>.from(map['members']?.map((x) => Members.fromMap(x)))
          : null,
      group: map['group'] != null ? Group.fromMap(map['group']) : null,
      projectdetail: map['projectdetail'] != null
          ? ProjectDetail.fromMap(map['projectdetail'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupDetail.fromJson(String source) =>
      GroupDetail.fromMap(json.decode(source));

  @override
  String toString() =>
      'GroupDetail(members: $members, group: $group, projectdetail: $projectdetail)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GroupDetail &&
        listEquals(other.members, members) &&
        other.group == group &&
        other.projectdetail == projectdetail;
  }

  @override
  int get hashCode =>
      members.hashCode ^ group.hashCode ^ projectdetail.hashCode;
}

class Members {
  int? id;
  int? studentId;

  String? platform;
  User? user;
  Members({
    this.id,
    this.studentId,
    this.platform,
    this.user,
  });

  Members copyWith({
    int? id,
    int? studentId,
    String? platform,
    User? user,
  }) {
    return Members(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      platform: platform ?? this.platform,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (studentId != null) {
      result.addAll({'studentId': studentId});
    }
    if (platform != null) {
      result.addAll({'platform': platform});
    }
    if (user != null) {
      result.addAll({'user': user!.toMap()});
    }

    return result;
  }

  factory Members.fromMap(Map<String, dynamic> map) {
    return Members(
      id: map['id']?.toInt(),
      studentId: map['studentId']?.toInt(),
      platform: map['platform'],
      user: map['user'] != null ? User.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Members.fromJson(String source) =>
      Members.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Members(id: $id, studentId: $studentId, platform: $platform, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Members &&
        other.id == id &&
        other.studentId == studentId &&
        other.platform == platform &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^ studentId.hashCode ^ platform.hashCode ^ user.hashCode;
  }
}

class User {
  String? arid_no;
  double? cgpa;
  int? semester;
  String? student_name;
  String? username;
  User({
    this.arid_no,
    this.cgpa,
    this.semester,
    this.student_name,
    this.username,
  });

  User copyWith({
    String? arid_no,
    double? cgpa,
    int? semester,
    String? student_name,
    String? username,
  }) {
    return User(
      arid_no: arid_no ?? this.arid_no,
      cgpa: cgpa ?? this.cgpa,
      semester: semester ?? this.semester,
      student_name: student_name ?? this.student_name,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (arid_no != null) {
      result.addAll({'arid_no': arid_no});
    }
    if (cgpa != null) {
      result.addAll({'cgpa': cgpa});
    }
    if (semester != null) {
      result.addAll({'semester': semester});
    }
    if (student_name != null) {
      result.addAll({'student_name': student_name});
    }
    if (username != null) {
      result.addAll({'username': username});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      arid_no: map['arid_no'],
      cgpa: map['cgpa']?.toDouble(),
      semester: map['semester']?.toInt(),
      student_name: map['student_name'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(arid_no: $arid_no, cgpa: $cgpa, semester: $semester, student_name: $student_name, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.arid_no == arid_no &&
        other.cgpa == cgpa &&
        other.semester == semester &&
        other.student_name == student_name &&
        other.username == username;
  }

  @override
  int get hashCode {
    return arid_no.hashCode ^
        cgpa.hashCode ^
        semester.hashCode ^
        student_name.hashCode ^
        username.hashCode;
  }
}

class Group {
  int? project_id;
  int? supervisor_id;
  Group({
    this.project_id,
    this.supervisor_id,
  });

  Group copyWith({
    int? project_id,
    int? supervisor_id,
  }) {
    return Group(
      project_id: project_id ?? this.project_id,
      supervisor_id: supervisor_id ?? this.supervisor_id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (project_id != null) {
      result.addAll({'project_id': project_id});
    }
    if (supervisor_id != null) {
      result.addAll({'supervisor_id': supervisor_id});
    }

    return result;
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      project_id: map['project_id']?.toInt(),
      supervisor_id: map['supervisor_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

  @override
  String toString() =>
      'Group(project_id: $project_id, supervisor_id: $supervisor_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Group &&
        other.project_id == project_id &&
        other.supervisor_id == supervisor_id;
  }

  @override
  int get hashCode => project_id.hashCode ^ supervisor_id.hashCode;
}

class ProjectDetail {
  String project_title;
  String project_status;
  ProjectDetail({
    required this.project_title,
    required this.project_status,
  });

  ProjectDetail copyWith({
    String? project_title,
    String? project_status,
  }) {
    return ProjectDetail(
      project_title: project_title ?? this.project_title,
      project_status: project_status ?? this.project_status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'project_title': project_title});
    result.addAll({'project_status': project_status});

    return result;
  }

  factory ProjectDetail.fromMap(Map<String, dynamic> map) {
    return ProjectDetail(
      project_title: map['project_title'] ?? '',
      project_status: map['project_status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDetail.fromJson(String source) =>
      ProjectDetail.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProjectDetail(project_title: $project_title, project_status: $project_status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectDetail &&
        other.project_title == project_title &&
        other.project_status == project_status;
  }

  @override
  int get hashCode => project_title.hashCode ^ project_status.hashCode;
}
