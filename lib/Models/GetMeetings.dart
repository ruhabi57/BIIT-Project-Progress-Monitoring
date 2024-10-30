class GetMeetings {
  final String description;
  final DateTime meetingDate;
  final String meetingStartTime;
  final bool isWithSupervisor;

  GetMeetings({
    required this.description,
    required this.meetingDate,
    required this.meetingStartTime,
    required this.isWithSupervisor,
  });

  factory GetMeetings.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Cannot parse null JSON');
    }

    return GetMeetings(
      description: json['description'] ?? '',
      meetingDate: json['meeting_date'] != null
          ? DateTime.parse(json['meeting_date'])
          : DateTime.now(), // Provide a default value if meeting_date is null
      meetingStartTime: json['meeting_starttime'] ?? '',
      isWithSupervisor: json['is_with_supervisor'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'meeting_date': meetingDate.toIso8601String(),
      'meeting_starttime': meetingStartTime,
      'is_with_supervisor': isWithSupervisor,
    };
  }
}

class GetAllMeetings {
  final String description;
  final DateTime meetingDate;
  final String meetingStartTime;
  final bool isWithSupervisor;
  final String meeting_endtime;
  final int meeting_id;

  GetAllMeetings({
    required this.description,
    required this.meetingDate,
    required this.meetingStartTime,
    required this.isWithSupervisor,
    required this.meeting_endtime,
    required this.meeting_id,
  });

  factory GetAllMeetings.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Cannot parse null JSON');
    }

    return GetAllMeetings(
      description: json['description'] ?? '',
      meetingDate: json['meeting_date'] != null
          ? DateTime.parse(json['meeting_date'])
          : DateTime.now(), // Provide a default value if meeting_date is null
      meetingStartTime: json['meeting_starttime'] ?? '',
      isWithSupervisor: json['is_with_supervisor'] ?? false,
      meeting_endtime: json['meeting_endtime'], meeting_id: json['meeting_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'meeting_date': meetingDate.toIso8601String(),
      'meeting_star             ttime': meetingStartTime,
      'is_with_supervisor': isWithSupervisor,
      'meeting_id': meeting_id,
      'meeting_endtime': meeting_endtime
    };
  }
}
