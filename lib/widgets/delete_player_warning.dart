import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';
import 'package:ligretto_counter/data/game_informations_data.dart';
import 'package:ligretto_counter/model/game_informations.dart';
import 'package:ligretto_counter/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

import '../data/player_data.dart';
import 'rounded_button_widget.dart';

class DeletePlayerWarning extends StatelessWidget {
  const DeletePlayerWarning(this.playerID, {Key? key}) : super(key: key);

  final int? playerID;

  @override
  Widget build(BuildContext context) {
    PlayerData playerData = context.read<PlayerData>();
    GameInformations gameInformations =
        context.read<GameInformationsData>().gameInformations;
    return CustomDialog(
      content: Column(
        children: const [
          Text(
            'Spieler*in löschen',
            textAlign: TextAlign.center,
            style: gameInformationHeadlineTextStyle,
          ),
          SizedBox(height: 10),
          Text(
            'Löschen eines Spielers führt zur dauerhaften Entfernung aller Daten, einschließlich des Punktestands.',
            textAlign: TextAlign.center,
            style: gameInformationTextStyle,
          )
        ],
      ),
      action: Row(
        children: [
          Expanded(
            child: RoundedButton(
              text: 'Schließen',
              color: kGreenColor,
              textColor: Colors.white,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RoundedButton(
              text: 'Löschen',
              color: kRedColor,
              textColor: Colors.white,
              onTap: () {
                playerData.deletePlayer(playerID!);

                if (gameInformations.winnerID == playerID) {
                  gameInformations.winnerID = null;
                }

                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
