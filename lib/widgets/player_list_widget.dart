import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ligretto_counter/data/settings_data.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/player.dart';
import '../data/player_data.dart';
import './circular_button_widget.dart';
import './content_box_widget.dart';
import './add_edit_player_widget.dart';

class PlayerListWidget extends StatefulWidget {
  final bool editPlayerMode;
  final bool showPoints;

  const PlayerListWidget({
    Key? key,
    required this.editPlayerMode,
    required this.showPoints,
  }) : super(key: key);

  @override
  State<PlayerListWidget> createState() => _PlayerListWidgetState();
}

class _PlayerListWidgetState extends State<PlayerListWidget> {
  @override
  Widget build(BuildContext context) {
    PlayerData playerData = context.read<PlayerData>();
    SettingsData settingsData = context.read<SettingsData>();
    List<Player> players = playerData.players;

    if (widget.showPoints || settingsData.settings.showPoints) {
      players = playerData.getSortedPlayers();
    }

    return ContentBox(
      height: 330,
      child: ListView.separated(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          Player player = players[index];

          return Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius - 5),
              color: const Color(0xFFF3F3F3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/character/character${player.character}.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 20),
                    Text(players[index].name, style: kPlayerNameTextStyle),
                  ],
                ),
                widget.editPlayerMode
                    ? Row(
                        children: [
                          CircularButton(
                            icon: Icons.edit,
                            hasShadow: false,
                            size: 40,
                            iconSize: 28,
                            backgroundColor: const Color(0xFFE6E6E6),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AddEditPlayer(
                                  editPlayer: true,
                                  playerToEditID: player.id,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          CircularButton(
                            icon: Icons.delete,
                            hasShadow: false,
                            size: 40,
                            iconSize: 30,
                            backgroundColor: const Color(0xFFE6E6E6),
                            onTap: () {
                              playerData.deletePlayer(player.id!);
                            },
                          ),
                        ],
                      )
                    : Container(
                        height: 50,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kBorderRadius - 10),
                          color: const Color(0xFFE6E6E6),
                        ),
                        child: Center(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: widget.showPoints ||
                                      settingsData.settings.showPoints
                                  ? 0
                                  : 7,
                              sigmaY: widget.showPoints ||
                                      settingsData.settings.showPoints
                                  ? 0
                                  : 7,
                            ),
                            child: Text(
                              widget.showPoints ||
                                      settingsData.settings.showPoints
                                  ? player.points.toString()
                                  : '0',
                              style: kPointsTextStyle,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
        itemCount: players.length,
      ),
    );
  }
}
