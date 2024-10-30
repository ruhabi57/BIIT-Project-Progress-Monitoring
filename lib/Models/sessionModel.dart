import 'dart:convert';

class Sessions {
  int? session_id;
  String? session_name;
  Sessions({
    this.session_id,
    this.session_name,
  });

  Sessions copyWith({
    int? session_id,
    String? session_name,
  }) {
    return Sessions(
      session_id: session_id ?? this.session_id,
      session_name: session_name ?? this.session_name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (session_id != null) {
      result.addAll({'session_id': session_id});
    }
    if (session_name != null) {
      result.addAll({'session_name': session_name});
    }

    return result;
  }

  factory Sessions.fromMap(Map<String, dynamic> map) {
    return Sessions(
      session_id: map['session_id']?.toInt(),
      session_name: map['session_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sessions.fromJson(String source) =>
      Sessions.fromMap(json.decode(source));

  @override
  String toString() =>
      'Sessions(session_id: $session_id, session_name: $session_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sessions &&
        other.session_id == session_id &&
        other.session_name == session_name;
  }

  @override
  int get hashCode => session_id.hashCode ^ session_name.hashCode;
}
