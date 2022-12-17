import 'package:flutter/material.dart';
import 'package:ligretto_counter/data/game_informations_data.dart';
import 'package:ligretto_counter/ligretto_counter_icons_icons.dart';
import 'package:ligretto_counter/model/player.dart';
import 'package:ligretto_counter/widgets/add_points_dialog.dart';
import 'package:ligretto_counter/widgets/circular_button_widget.dart';
import 'package:ligretto_counter/widgets/add_edit_player_widget.dart';
import 'package:ligretto_counter/widgets/settings_widget.dart';
import 'package:provider/provider.dart';

import '../data/player_data.dart';
import './too_many_player.dart';

class ActionsRow extends StatelessWidget {
  final Function() switchEditPlayerMode;
  final bool editPlayerMode;

  const ActionsRow({
    Key? key,
    required this.switchEditPlayerMode,
    required this.editPlayerMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerData playerData = context.read<PlayerData>();
    GameInformationsData gameInformationsData =
        context.read<GameInformationsData>();

    List<Player> players = playerData.players;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularButton(
          icon: LigrettoCounterIcons.add_user,
          onTap: () {
            if (players.length < 4) {
              showDialog(
                context: context,
                builder: (context) => const AddEditPlayer(editPlayer: false),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => const TooManyPlayers(),
              );
            }
          },
        ),
        CircularButton(
          backgroundColor: editPlayerMode ? Colors.grey : Colors.white,
          icon: LigrettoCounterIcons.edit_user,
          onTap: switchEditPlayerMode,
        ),
        CircularButton(
          icon: LigrettoCounterIcons.add_points,
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => const AddPointsDialog());
          },
        ),
        CircularButton(
          icon: LigrettoCounterIcons.reset,
          onTap: () {
            playerData.resetAllPoints();
            gameInformationsData.resetGameInformations();
            gameInformationsData.setEvaluated = false;
          },
        ),
        CircularButton(
          icon: LigrettoCounterIcons.settings,
          onTap: () {
            showDialog(
                context: context, builder: (context) => const SettingsWidget());
          },
        ),
      ],
    );
  }
}
