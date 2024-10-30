import 'dart:convert';

class SupervisorModel {
  int user_id;
  String? username;
  String? name;
  int supervisor_id;
  int? groupCount;
  SupervisorModel({
    required this.user_id,
    required this.username,
    this.name,
    required this.supervisor_id,
    this.groupCount,
  });

  SupervisorModel copyWith({
    int? user_id,
    String? username,
    String? name,
    int? supervisor_id,
    int? groupCount,
  }) {
    return SupervisorModel(
      user_id: user_id ?? this.user_id,
      username: username ?? this.username,
      name: name ?? this.name,
      supervisor_id: supervisor_id ?? this.supervisor_id,
      groupCount: groupCount ?? this.groupCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_id': user_id});
    if (username != null) {
      result.addAll({'username': username});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    result.addAll({'supervisor_id': supervisor_id});
    if (groupCount != null) {
      result.addAll({'groupCount': groupCount});
    }

    return result;
  }

  factory SupervisorModel.fromMap(Map<String, dynamic> map) {
    return SupervisorModel(
      user_id: map['user_id']?.toInt() ?? 0,
      username: map['username'],
      name: map['name'],
      supervisor_id: map['supervisor_id']?.toInt() ?? 0,
      groupCount: map['groupCount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupervisorModel.fromJson(String source) =>
      SupervisorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SupervisorModel(user_id: $user_id, username: $username, name: $name, supervisor_id: $supervisor_id, groupCount: $groupCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupervisorModel &&
        other.user_id == user_id &&
        other.username == username &&
        other.name == name &&
        other.supervisor_id == supervisor_id &&
        other.groupCount == groupCount;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        username.hashCode ^
        name.hashCode ^
        supervisor_id.hashCode ^
        groupCount.hashCode;
  }
}

class SupervisorPreference {
  final int supervisor_id;
  final int group_id;
  final bool status;

  SupervisorPreference({
    required this.supervisor_id,
    required this.group_id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'supervisor_id': supervisor_id});
    result.addAll({'group_id': group_id});
    result.addAll({'status': status});

    return result;
  }

  SupervisorPreference copyWith({
    int? supervisor_id,
    int? group_id,
    bool? status,
  }) {
    return SupervisorPreference(
      supervisor_id: supervisor_id ?? this.supervisor_id,
      group_id: group_id ?? this.group_id,
      status: status ?? this.status,
    );
  }

  factory SupervisorPreference.fromMap(Map<String, dynamic> map) {
    return SupervisorPreference(
      supervisor_id: map['supervisor_id']?.toInt() ?? 0,
      group_id: map['group_id']?.toInt() ?? 0,
      status: map['status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupervisorPreference.fromJson(String source) =>
      SupervisorPreference.fromMap(json.decode(source));

  @override
  String toString() =>
      'SupervisorPreference(supervisor_id: $supervisor_id, group_id: $group_id, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupervisorPreference &&
        other.supervisor_id == supervisor_id &&
        other.group_id == group_id &&
        other.status == status;
  }

  @override
  int get hashCode =>
      supervisor_id.hashCode ^ group_id.hashCode ^ status.hashCode;
}

class SupervisorGroups {
  int? ProjectId;
  String ProjectTitle;
  int GroupId;
  SupervisorGroups({
    this.ProjectId,
    required this.ProjectTitle,
    required this.GroupId,
  });

  SupervisorGroups copyWith({
    int? ProjectId,
    String? ProjectTitle,
    int? GroupId,
  }) {
    return SupervisorGroups(
      ProjectId: ProjectId ?? this.ProjectId,
      ProjectTitle: ProjectTitle ?? this.ProjectTitle,
      GroupId: GroupId ?? this.GroupId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (ProjectId != null) {
      result.addAll({'ProjectId': ProjectId});
    }
    result.addAll({'ProjectTitle': ProjectTitle});
    result.addAll({'GroupId': GroupId});

    return result;
  }

  factory SupervisorGroups.fromMap(Map<String, dynamic> map) {
    return SupervisorGroups(
      ProjectId: map['ProjectId']?.toInt(),
      ProjectTitle: map['ProjectTitle'] ?? '',
      GroupId: map['GroupId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupervisorGroups.fromJson(Map<String, dynamic> source) =>
      SupervisorGroups.fromMap(source);

  @override
  String toString() =>
      'SupervisorGroups(ProjectId: $ProjectId, ProjectTitle: $ProjectTitle, GroupId: $GroupId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupervisorGroups &&
        other.ProjectId == ProjectId &&
        other.ProjectTitle == ProjectTitle &&
        other.GroupId == GroupId;
  }

  @override
  int get hashCode =>
      ProjectId.hashCode ^ ProjectTitle.hashCode ^ GroupId.hashCode;
}
