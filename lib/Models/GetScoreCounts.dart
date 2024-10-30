import 'dart:convert';

class GetScoreCounts {
  int supervisorid;
  String supervisorname;
  int totalcounts;
  GetScoreCounts({
    required this.supervisorid,
    required this.supervisorname,
    required this.totalcounts,
  });

  GetScoreCounts copyWith({
    int? supervisorid,
    String? supervisorname,
    int? totalcounts,
  }) {
    return GetScoreCounts(
      supervisorid: supervisorid ?? this.supervisorid,
      supervisorname: supervisorname ?? this.supervisorname,
      totalcounts: totalcounts ?? this.totalcounts,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'supervisorid': supervisorid});
    result.addAll({'supervisorname': supervisorname});
    result.addAll({'totalcounts': totalcounts});

    return result;
  }

  factory GetScoreCounts.fromMap(Map<String, dynamic> map) {
    return GetScoreCounts(
      supervisorid: map['supervisorid']?.toInt() ?? 0,
      supervisorname: map['supervisorname'] ?? '',
      totalcounts: map['totalcounts']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetScoreCounts.fromJson(String source) =>
      GetScoreCounts.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetScoreCounts(supervisorid: $supervisorid, supervisorname: $supervisorname, totalcounts: $totalcounts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetScoreCounts &&
        other.supervisorid == supervisorid &&
        other.supervisorname == supervisorname &&
        other.totalcounts == totalcounts;
  }

  @override
  int get hashCode =>
      supervisorid.hashCode ^ supervisorname.hashCode ^ totalcounts.hashCode;
}
