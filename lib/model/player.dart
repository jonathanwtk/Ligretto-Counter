import 'package:ligretto_counter/db/ligretto_counter_database.dart';
import 'package:ligretto_counter/model/points.dart';

const String tablePlayer = 'player';

class PlayerFields {
  static final List<String> values = [
    id,
    name,
    character,
    points,
    lastRoundScore
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String character = 'character';
  static const String lastRoundScore = 'lastRoundScore';
  static const String points = 'points';
}

class Player {
  final int? id;
  final String name;
  final int character;
  int points;
  int lastRoundScore;
  List<Points> pointsHistory;

  Player({
    this.id,
    required this.name,
    required this.character,
    required this.pointsHistory,
    this.lastRoundScore = 0,
    this.points = 0,
  });

  Player copy({
    int? id,
    String? name,
    int? character,
    int? points,
    int? lastRoundScore,
    List<Points>? pointsHistory,
  }) =>
      Player(
        id: id ?? this.id,
        name: name ?? this.name,
        character: character ?? this.character,
        pointsHistory: pointsHistory ?? this.pointsHistory,
        lastRoundScore: lastRoundScore ?? this.lastRoundScore,
        points: points ?? this.points,
      );

  static Future<Player> fromJson(Map<String, Object?> json) async => Player(
        id: json[PlayerFields.id] as int?,
        name: json[PlayerFields.name] as String,
        character: json[PlayerFields.character] as int,
        pointsHistory: await LigrettoCounterDatabase.instance.readPoints(
          where: '${PointsFields.playerID} = ?',
          whereArgs: [json[PlayerFields.id] as int],
        ),
        lastRoundScore: json[PlayerFields.lastRoundScore] as int,
        points: json[PlayerFields.points] as int,
      );

  Map<String, Object?> toJson() => {
        PlayerFields.id: id,
        PlayerFields.name: name,
        PlayerFields.character: character,
        PlayerFields.points: points,
        PlayerFields.lastRoundScore: lastRoundScore,
      };
}
