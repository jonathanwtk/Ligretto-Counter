const String tablePoints = 'points';

class PointsFields {
  static final List<String> values = [id, playerID, points, roundIndex];

  static const String id = '_id';
  static const String playerID = 'playerID';
  static const String points = 'points';
  static const String roundIndex = 'roundIndex';
}

class Points {
  int? id;
  int playerID;
  int points;
  int roundIndex;

  Points({
    this.id,
    required this.playerID,
    required this.points,
    required this.roundIndex,
  });

  Points copy({
    int? id,
    int? playerID,
    int? points,
    int? roundIndex,
  }) =>
      Points(
        id: id ?? this.id,
        playerID: playerID ?? this.playerID,
        points: points ?? this.points,
        roundIndex: roundIndex ?? this.roundIndex,
      );

  static Points fromJson(Map<String, Object?> json) => Points(
        id: json[PointsFields.id] as int?,
        playerID: json[PointsFields.playerID] as int,
        points: json[PointsFields.points] as int,
        roundIndex: json[PointsFields.roundIndex] as int,
      );

  Map<String, Object?> toJson() => {
        PointsFields.id: id,
        PointsFields.playerID: playerID,
        PointsFields.points: points,
        PointsFields.roundIndex: roundIndex,
      };
}
