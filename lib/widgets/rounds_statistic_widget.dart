import 'package:flutter/material.dart';
import 'package:ligretto_counter/data/game_informations_data.dart';
import 'package:ligretto_counter/data/player_data.dart';
import 'package:ligretto_counter/model/game_informations.dart';
import 'package:ligretto_counter/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/player.dart';
import 'content_box_widget.dart';
import 'rounded_button_widget.dart';

class RoundsStatistic extends StatelessWidget {
  const RoundsStatistic({Key? key}) : super(key: key);

  String getPlayerPointsString(Player player, int roundIndex) {
    String playerPointsString = "-";

    if (player.pointsHistory.any((points) => points.roundIndex == roundIndex)) {
      int playerRoundPoints = player.pointsHistory
          .firstWhere((points) => points.roundIndex == roundIndex)
          .points;

      if (playerRoundPoints == 0) {
        playerPointsString = '0';
      } else if (playerRoundPoints.isNegative) {
        playerPointsString = playerRoundPoints.toString();
      } else {
        playerPointsString = '+' + playerRoundPoints.toString();
      }
    }

    return playerPointsString;
  }

  Color getPlayerPointsColor(Player player, int roundIndex) {
    if (player.pointsHistory.any((points) => points.roundIndex == roundIndex)) {
      int playerRoundPoints = player.pointsHistory
          .firstWhere((points) => points.roundIndex == roundIndex)
          .points;
      return playerRoundPoints.isNegative ? kRedColor : const Color(0xFF129443);
    }
    return Colors.grey.shade300;
  }

  List<TableRow> getPlayerTableRows(
      List<Player> players, GameInformations gameInformations) {
    List<Column> nameColumns = [];

    for (var player in players) {
      nameColumns.add(
        Column(
          children: [
            Text(
              player.name,
              style: gameInformationTextStyle,
              softWrap: false,
            ),
          ],
        ),
      );
    }

    List<TableRow> playerTableRows = [
      TableRow(
        children: nameColumns,
      ),
    ];

    for (var i = 0; i < gameInformations.roundNumber; i++) {
      List<Column> pointsColumns = [];
      for (var player in players) {
        pointsColumns.add(
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: ContentBox(
                  width: 50,
                  height: 30,
                  hasShadow: false,
                  color: getPlayerPointsColor(player, i),
                  child: Center(
                    child: Text(
                      getPlayerPointsString(player, i),
                      style: kTextFieldTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      playerTableRows.add(TableRow(children: pointsColumns));
    }

    return playerTableRows;
  }

  @override
  Widget build(BuildContext context) {
    PlayerData playerData = context.watch<PlayerData>();
    GameInformations gameInformations =
        context.watch<GameInformationsData>().gameInformations;

    return CustomDialog(
      action: RoundedButton(
        text: 'Schließen',
        color: kRedColor,
        textColor: Colors.white,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      content: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: getPlayerTableRows(playerData.players, gameInformations),
      ),
    );
  }
}
