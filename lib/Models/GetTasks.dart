import 'dart:convert';

class GetTasks {
  int? task_id;
  String file_name;
  String task_description;
  String task_status;
  bool is_from_supervisor;
  DateTime deadline;
  GetTasks({
    this.task_id,
    required this.file_name,
    required this.task_description,
    required this.task_status,
    required this.is_from_supervisor,
    required this.deadline,
  });

  GetTasks copyWith({
    int? task_id,
    String? file_name,
    String? task_description,
    String? task_status,
    bool? is_from_supervisor,
    DateTime? deadline,
  }) {
    return GetTasks(
      task_id: task_id ?? this.task_id,
      file_name: file_name ?? this.file_name,
      task_description: task_description ?? this.task_description,
      task_status: task_status ?? this.task_status,
      is_from_supervisor: is_from_supervisor ?? this.is_from_supervisor,
      deadline: deadline ?? this.deadline,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (task_id != null) {
      result.addAll({'task_id': task_id});
    }
    result.addAll({'file_name': file_name});
    result.addAll({'task_description': task_description});
    result.addAll({'task_status': task_status});
    result.addAll({'is_from_supervisor': is_from_supervisor});
    result.addAll({'deadline': deadline.millisecondsSinceEpoch});

    return result;
  }

  factory GetTasks.fromMap(Map<String, dynamic> map) {
    return GetTasks(
      task_id: map['task_id']?.toInt(),
      file_name: map['file_name'] ?? '',
      task_description: map['task_description'] ?? '',
      task_status: map['task_status'] ?? '',
      is_from_supervisor: map['is_from_supervisor'] ?? false,
      deadline: DateTime.parse(map['deadline']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetTasks.fromJson(String source) =>
      GetTasks.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetTasks(task_id: $task_id, file_name: $file_name, task_description: $task_description, task_status: $task_status, is_from_supervisor: $is_from_supervisor, deadline: $deadline)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetTasks &&
        other.task_id == task_id &&
        other.file_name == file_name &&
        other.task_description == task_description &&
        other.task_status == task_status &&
        other.is_from_supervisor == is_from_supervisor &&
        other.deadline == deadline;
  }

  @override
  int get hashCode {
    return task_id.hashCode ^
        file_name.hashCode ^
        task_description.hashCode ^
        task_status.hashCode ^
        is_from_supervisor.hashCode ^
        deadline.hashCode;
  }
}

class GetAllTasksforCommittee {
  int? task_id;
  String task_description;
  String task_status;
  DateTime deadline;
  String file_name;
  int? project_id;

  GetAllTasksforCommittee({
    this.task_id,
    required this.task_description,
    required this.task_status,
    required this.deadline,
    required this.file_name,
    this.project_id,
  });

  GetAllTasksforCommittee copyWith({
    int? task_id,
    String? task_description,
    String? task_status,
    DateTime? deadline,
    String? file_name,
    int? project_id,
  }) {
    return GetAllTasksforCommittee(
      task_id: task_id ?? this.task_id,
      task_description: task_description ?? this.task_description,
      task_status: task_status ?? this.task_status,
      deadline: deadline ?? this.deadline,
      file_name: file_name ?? this.file_name,
      project_id: project_id ?? this.project_id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (task_id != null) {
      result.addAll({'task_id': task_id});
    }
    result.addAll({'task_description': task_description});
    result.addAll({'task_status': task_status});
    result.addAll({'deadline': deadline.millisecondsSinceEpoch});
    result.addAll({'file_name': file_name});
    if (project_id != null) {
      result.addAll({'project_id': project_id});
    }

    return result;
  }

  factory GetAllTasksforCommittee.fromMap(Map<String, dynamic> map) {
    return GetAllTasksforCommittee(
      task_id: map['task_id']?.toInt(),
      task_description: map['task_description'] ?? '',
      task_status: map['task_status'] ?? '',
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline']),
      file_name: map['file_name'] ?? '',
      project_id: map['project_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllTasksforCommittee.fromJson(String source) =>
      GetAllTasksforCommittee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetAllTasksforCommittee(task_id: $task_id, task_description: $task_description, task_status: $task_status, deadline: $deadline, file_name: $file_name, project_id: $project_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllTasksforCommittee &&
        other.task_id == task_id &&
        other.task_description == task_description &&
        other.task_status == task_status &&
        other.deadline == deadline &&
        other.file_name == file_name &&
        other.project_id == project_id;
  }

  @override
  int get hashCode {
    return task_id.hashCode ^
        task_description.hashCode ^
        task_status.hashCode ^
        deadline.hashCode ^
        file_name.hashCode ^
        project_id.hashCode;
  }
}
