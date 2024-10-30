import 'dart:convert';

class Criteria {
  int? score_id;
  String criteria;
  int score_weight_id;
  int score_weight;
  Criteria({
    this.score_id,
    required this.criteria,
    required this.score_weight_id,
    required this.score_weight,
  });

  Criteria copyWith({
    int? score_id,
    String? criteria,
    int? score_weight_id,
    int? score_weight,
  }) {
    return Criteria(
      score_id: score_id ?? this.score_id,
      criteria: criteria ?? this.criteria,
      score_weight_id: score_weight_id ?? this.score_weight_id,
      score_weight: score_weight ?? this.score_weight,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (score_id != null) {
      result.addAll({'score_id': score_id});
    }
    result.addAll({'criteria': criteria});
    result.addAll({'score_weight_id': score_weight_id});
    result.addAll({'score_weight': score_weight});

    return result;
  }

  factory Criteria.fromMap(Map<String, dynamic> map) {
    return Criteria(
      score_id: map['score_id']?.toInt(),
      criteria: map['criteria'] ?? '',
      score_weight_id: map['score_weight_id']?.toInt() ?? 0,
      score_weight: map['score_weight']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Criteria.fromJson(String source) =>
      Criteria.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Criteria(score_id: $score_id, criteria: $criteria, score_weight_id: $score_weight_id, score_weight: $score_weight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Criteria &&
        other.score_id == score_id &&
        other.criteria == criteria &&
        other.score_weight_id == score_weight_id &&
        other.score_weight == score_weight;
  }

  @override
  int get hashCode {
    return score_id.hashCode ^
        criteria.hashCode ^
        score_weight_id.hashCode ^
        score_weight.hashCode;
  }
}
