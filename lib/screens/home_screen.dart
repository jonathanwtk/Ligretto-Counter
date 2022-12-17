import 'package:flutter/material.dart';
import 'package:ligretto_counter/data/game_informations_data.dart';
import 'package:ligretto_counter/data/settings_data.dart';
import 'package:provider/provider.dart';

import '../data/player_data.dart';
import '../db/ligretto_counter_database.dart';
import '../widgets/actions_row_widget.dart';
import '../widgets/player_list_widget.dart';
import '../widgets/rounded_button_widget.dart';
import '../widgets/game_information_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool editPlayerMode = false;
  bool initialised = false;

  @override
  Widget build(BuildContext context) {
    PlayerData playerData = context.watch<PlayerData>();
    SettingsData settingsData = context.watch<SettingsData>();
    GameInformationsData gameInformationsData =
        context.watch<GameInformationsData>();
    bool evaluated = gameInformationsData.gameInformations.evaluated;

    Future<bool> loadData() async {
      if (initialised) return true;

      playerData.players =
          await LigrettoCounterDatabase.instance.readAllPlayer();
      settingsData.settings =
          await LigrettoCounterDatabase.instance.readSettings();
      gameInformationsData.gameInformations =
          await LigrettoCounterDatabase.instance.readGameInformations();

      return true;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF941912),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          initialised = true;

          return SafeArea(
            maintainBottomViewPadding: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/ligretto_logo.png', height: 60),
                  const GameInformation(),
                  ActionsRow(
                    editPlayerMode: editPlayerMode,
                    switchEditPlayerMode: () {
                      setState(() {
                        editPlayerMode = !editPlayerMode;
                      });
                    },
                  ),
                  PlayerListWidget(
                    editPlayerMode: editPlayerMode,
                    showPoints: evaluated,
                  ),
                  RoundedButton(
                    text: evaluated ? 'Zurücksetzen' : 'Auswerten',
                    onTap: () {
                      if (evaluated) {
                        playerData.resetAllPoints();
                        gameInformationsData.resetGameInformations();
                      }

                      gameInformationsData.setEvaluated = !evaluated;
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
