import 'package:flutter/material.dart';
import 'package:ligretto_counter/model/game_informations.dart';
import 'package:ligretto_counter/model/points.dart';

import '../db/ligretto_counter_database.dart';
import '../model/player.dart';

class PlayerData with ChangeNotifier {
  List<Player> players = [];

  Future addPlayer(Player player) async {
    players.add(await LigrettoCounterDatabase.instance.create(player));

    notifyListeners();
  }

  Future editPlayer(Player updatedPlayer) async {
    players[players.indexWhere((player) => player.id == updatedPlayer.id)] =
        updatedPlayer;
    await LigrettoCounterDatabase.instance.update(updatedPlayer);

    notifyListeners();
  }

  Future deletePlayer(int id) async {
    await LigrettoCounterDatabase.instance.delete(id);
    players.removeWhere((player) => player.id == id);

    notifyListeners();
  }

  Future addPoints(
      int id, int points, GameInformations gameInformations) async {
    Player player = players.firstWhere((player) => player.id == id);

    player.points += points;
    player.lastRoundScore = points;
    player.pointsHistory.add(
      await LigrettoCounterDatabase.instance.createPoints(
        Points(
          playerID: id,
          points: points,
          roundIndex: gameInformations.roundNumber,
        ),
      ),
    );

    await LigrettoCounterDatabase.instance.update(player);

    notifyListeners();
  }

  Future resetAllPoints() async {
    for (var player in players) {
      player.points = 0;
      player.lastRoundScore = 0;
      player.pointsHistory.clear();
      await LigrettoCounterDatabase.instance.update(player);
    }

    notifyListeners();
  }

  List<Player> getSortedPlayers() {
    List<Player> sortedPlayers = List<Player>.from(players);

    sortedPlayers.sort((a, b) => b.points.compareTo(a.points));
    return sortedPlayers;
  }
}
