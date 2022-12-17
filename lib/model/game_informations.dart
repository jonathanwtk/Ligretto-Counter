const String tableGameInformations = 'gameInformations';

class GameInformationsFields {
  static const List<String> values = [id, winnerID, roundNumber];

  static const String id = '_id';
  static const String winnerID = 'winnerID';
  static const String roundNumber = 'roundNumber';
}

class GameInformations {
  int? id;
  int? winnerID;
  int roundNumber;
  bool evaluated;

  GameInformations({
    this.id,
    this.winnerID,
    this.roundNumber = 0,
    this.evaluated = false,
  });

  GameInformations copy({int? id, int? winnerID, int? roundNumber}) =>
      GameInformations(
        id: id ?? this.id,
        winnerID: winnerID ?? this.winnerID,
        roundNumber: roundNumber ?? this.roundNumber,
      );

  static GameInformations fromJson(Map<String, Object?> json) =>
      GameInformations(
        id: json[GameInformationsFields.id] as int?,
        winnerID: json[GameInformationsFields.winnerID] as int?,
        roundNumber: json[GameInformationsFields.roundNumber] as int,
      );

  Map<String, Object?> toJson() => {
        GameInformationsFields.id: id,
        GameInformationsFields.winnerID: winnerID,
        GameInformationsFields.roundNumber: roundNumber,
      };
}
