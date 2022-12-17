import 'package:flutter/material.dart';
import 'package:ligretto_counter/data/player_data.dart';
import 'package:ligretto_counter/db/ligretto_counter_database.dart';
import 'package:ligretto_counter/model/game_informations.dart';
import 'package:ligretto_counter/model/player.dart';

class GameInformationsData with ChangeNotifier {
  GameInformations gameInformations = GameInformations(roundNumber: 0);

  Future updateGameInformations(PlayerData playerData) async {
    gameInformations.roundNumber++;

    List<Player> sortedPlayers = List<Player>.from(playerData.players);
    sortedPlayers.sort((a, b) => b.lastRoundScore.compareTo(a.lastRoundScore));
    gameInformations.winnerID = sortedPlayers.first.id;

    await LigrettoCounterDatabase.instance
        .updateGameInformations(gameInformations);

    notifyListeners();
  }

  set setEvaluated(bool newValue) {
    gameInformations.evaluated = newValue;

    notifyListeners();
  }

  Future resetGameInformations() async {
    gameInformations.roundNumber = 0;
    gameInformations.winnerID = null;

    await LigrettoCounterDatabase.instance
        .updateGameInformations(gameInformations);

    notifyListeners();
  }
}
