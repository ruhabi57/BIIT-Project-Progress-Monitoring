import 'dart:convert';

class GradesCounts {
  String? name;
  int AplusCount;
  int ACount;
  int AminusCount;
  int BCount;
  int CCount;
  int DCount;
  int FCount;
  GradesCounts({
    this.name,
    required this.AplusCount,
    required this.ACount,
    required this.AminusCount,
    required this.BCount,
    required this.CCount,
    required this.DCount,
    required this.FCount,
  });

  GradesCounts copyWith({
    String? name,
    int? AplusCount,
    int? ACount,
    int? AminusCount,
    int? BCount,
    int? CCount,
    int? DCount,
    int? FCount,
  }) {
    return GradesCounts(
      name: name ?? this.name,
      AplusCount: AplusCount ?? this.AplusCount,
      ACount: ACount ?? this.ACount,
      AminusCount: AminusCount ?? this.AminusCount,
      BCount: BCount ?? this.BCount,
      CCount: CCount ?? this.CCount,
      DCount: DCount ?? this.DCount,
      FCount: FCount ?? this.FCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    result.addAll({'AplusCount': AplusCount});
    result.addAll({'ACount': ACount});
    result.addAll({'AminusCount': AminusCount});
    result.addAll({'BCount': BCount});
    result.addAll({'CCount': CCount});
    result.addAll({'DCount': DCount});
    result.addAll({'FCount': FCount});

    return result;
  }

  factory GradesCounts.fromMap(Map<String, dynamic> map) {
    return GradesCounts(
      name: map['name'],
      AplusCount: map['AplusCount']?.toInt() ?? 0,
      ACount: map['ACount']?.toInt() ?? 0,
      AminusCount: map['AminusCount']?.toInt() ?? 0,
      BCount: map['BCount']?.toInt() ?? 0,
      CCount: map['CCount']?.toInt() ?? 0,
      DCount: map['DCount']?.toInt() ?? 0,
      FCount: map['FCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GradesCounts.fromJson(String source) =>
      GradesCounts.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GradesCounts(name: $name, AplusCount: $AplusCount, ACount: $ACount, AminusCount: $AminusCount, BCount: $BCount, CCount: $CCount, DCount: $DCount, FCount: $FCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GradesCounts &&
        other.name == name &&
        other.AplusCount == AplusCount &&
        other.ACount == ACount &&
        other.AminusCount == AminusCount &&
        other.BCount == BCount &&
        other.CCount == CCount &&
        other.DCount == DCount &&
        other.FCount == FCount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        AplusCount.hashCode ^
        ACount.hashCode ^
        AminusCount.hashCode ^
        BCount.hashCode ^
        CCount.hashCode ^
        DCount.hashCode ^
        FCount.hashCode;
  }
}
