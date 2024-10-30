class Grade {
  int? StudentId;
  String Grades;
  List<Scores> scores;

  Grade({this.StudentId, required this.Grades, required this.scores});

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      StudentId: map['StudentId']?.toInt(),
      Grades: map['Grades'] ?? '',
      scores: map['Scores'] != null
          ? List<Scores>.from(map['Scores'].map((x) => Scores.fromMap(x)))
          : [],
    );
  }
}

class Scores {
  int? ScoreId;
  int? AverageScore;
  int? ScoreWeight;
  String? Criteria;

  Scores({this.ScoreId, this.AverageScore, this.ScoreWeight, this.Criteria});

  factory Scores.fromMap(Map<String, dynamic> map) {
    return Scores(
      ScoreId: map['ScoreId']?.toInt(),
      AverageScore: map['AverageScore']?.toInt(),
      ScoreWeight: map['ScoreWeight']?.toInt(),
      Criteria: map['Criteria'],
    );
  }
}
