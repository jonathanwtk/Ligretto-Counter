import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ligretto_counter/data/game_informations_data.dart';
import 'package:ligretto_counter/widgets/content_box_widget.dart';
import 'package:ligretto_counter/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../data/player_data.dart';
import '../model/player.dart';
import './rounded_button_widget.dart';

class AddPointsDialog extends StatelessWidget {
  const AddPointsDialog({Key? key}) : super(key: key);

  List<TableRow> getPlayerTableRows(
    Map<int, TextEditingController> ligrettoStabelControllers,
    Map<int, TextEditingController> tischControllers,
    List<Player> players,
  ) {
    List<TableRow> playerTableRows = [
      TableRow(
        children: [
          Column(),
          Column(
            children: const [
              Text(
                'Ligretto-Stapel',
                style: gameInformationTextStyle,
                softWrap: false,
              )
            ],
          ),
          Column(
            children: const [
              Text(
                'Tischmitte',
                style: gameInformationTextStyle,
                softWrap: false,
              )
            ],
          ),
        ],
      ),
    ];

    for (var player in players) {
      playerTableRows.add(
        TableRow(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${player.name}:',
                  style: gameInformationHeadlineTextStyle,
                  softWrap: false,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ContentBox(
                    width: 70,
                    height: 40,
                    hasShadow: false,
                    color: const Color(0xFFE6E6E6),
                    child: Center(
                      child: TextField(
                        controller: ligrettoStabelControllers[player.id!],
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 2,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: kTextFieldTextStyle,
                        decoration:
                            kPointsInputdecoration.copyWith(hintText: '0'),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                ContentBox(
                  width: 70,
                  height: 40,
                  hasShadow: false,
                  color: const Color(0xFFE6E6E6),
                  child: Center(
                    child: TextField(
                      controller: tischControllers[player.id!],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: kTextFieldTextStyle,
                      decoration:
                          kPointsInputdecoration.copyWith(hintText: '0'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return playerTableRows;
  }

  @override
  Widget build(BuildContext context) {
    PlayerData playerData = context.read<PlayerData>();
    GameInformationsData gameInformationsData =
        context.read<GameInformationsData>();
    List<Player> players = playerData.players;
    Map<int, TextEditingController> ligrettoStapelControllers = {};
    Map<int, TextEditingController> tischControllers = {};

    for (var player in players) {
      ligrettoStapelControllers[player.id!] = TextEditingController();
      tischControllers[player.id!] = TextEditingController();
    }

    return CustomDialog(
      content: Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(flex: 2),
          1: IntrinsicColumnWidth(flex: 3),
          2: IntrinsicColumnWidth(flex: 3),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: getPlayerTableRows(
            ligrettoStapelControllers, tischControllers, players),
      ),
      action: RoundedButton(
        text: 'Punkteanzahl übernehmen',
        color: kRedColor,
        textColor: Colors.white,
        onTap: () {
          for (var player in players) {
            int ligrettoStapel = int.parse(
                ligrettoStapelControllers[player.id!]!.text != ''
                    ? ligrettoStapelControllers[player.id!]!.text
                    : '0');
            int tischMitte = int.parse(tischControllers[player.id!]!.text != ''
                ? tischControllers[player.id!]!.text
                : '0');

            playerData.addPoints(player.id!, -ligrettoStapel * 2 + tischMitte,
                gameInformationsData.gameInformations);
          }

          gameInformationsData.updateGameInformations(playerData);

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
