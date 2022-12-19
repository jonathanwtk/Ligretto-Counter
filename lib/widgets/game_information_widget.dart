import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ligretto_counter/data/player_data.dart';
import 'package:ligretto_counter/widgets/rounds_statistic_widget.dart';
import '../data/game_informations_data.dart';
import './content_box_widget.dart';
import '../constants.dart';

class GameInformation extends StatelessWidget {
  const GameInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerData playerData = context.watch<PlayerData>();
    GameInformationsData gameInformationsData =
        context.watch<GameInformationsData>();

    return ContentBox(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Spielinformationen',
              style: gameInformationHeadlineTextStyle,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Rundenanzahl: ${gameInformationsData.gameInformations.roundNumber}',
            style: gameInformationTextStyle,
          ),
          const SizedBox(height: 5),
          Text(
            'Rundengewinner*in: ${gameInformationsData.gameInformations.winnerID != null && gameInformationsData.gameInformations.roundNumber > 0 ? playerData.players.firstWhere((player) => player.id == gameInformationsData.gameInformations.winnerID).name : '-'}',
            style: gameInformationTextStyle,
          ),
          const SizedBox(height: 5),
          Text(
            'Punktedifferenz: ${gameInformationsData.gameInformations.roundNumber != 0 && playerData.players.length > 1 ? playerData.getSortedPlayers().first.points - playerData.getSortedPlayers().last.points : '-'}',
            style: gameInformationTextStyle,
          ),
          const SizedBox(height: 5),
          GestureDetector(
            child: const Text(
              'Rundenstatistik anzeigen',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Bubblegum',
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => const RoundsStatistic());
            },
          ),
        ],
      ),
    );
  }
}
