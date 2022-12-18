import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';
import 'package:ligretto_counter/model/player.dart';
import 'package:ligretto_counter/widgets/character_selection_card_widget.dart';
import 'package:ligretto_counter/widgets/content_box_widget.dart';
import 'package:ligretto_counter/widgets/custom_dialog.dart';
import 'package:ligretto_counter/widgets/player_list_widget.dart';
import 'package:ligretto_counter/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../data/player_data.dart';

class AddEditPlayerScreen extends StatefulWidget {
  final bool editPlayer;
  final int? playerToEditID;

  const AddEditPlayerScreen({
    Key? key,
    required this.editPlayer,
    this.playerToEditID,
  }) : super(key: key);

  @override
  State<AddEditPlayerScreen> createState() => _AddEditPlayerScreenState();
}

class _AddEditPlayerScreenState extends State<AddEditPlayerScreen> {
  int selectedCharacter = 0;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PlayerData playerData = context.read<PlayerData>();

    if (widget.editPlayer) {
      Player player = playerData.players
          .firstWhere((player) => player.id == widget.playerToEditID!);

      nameController.text = player.name;
      selectedCharacter = player.character;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF941912),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Text(
                        widget.editPlayer
                            ? 'Spieler*in bearbeiten'
                            : 'Spieler*in hinzufügen',
                        textAlign: TextAlign.center,
                        style: gameInformationHeadlineTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(),
                  ],
                ),
                const SizedBox(height: 20),
                ContentBox(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      const Text(
                        'Name',
                        style: gameInformationTextStyle,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: nameController,
                        style: kTextFieldTextStyle,
                        decoration: kNameInputdecoration('Name'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Charakter',
                        style: gameInformationTextStyle,
                      ),
                      const SizedBox(height: 5),
                      SelectCharacter(
                        selectedCharacter: selectedCharacter,
                        onChange: (newIndex) => selectedCharacter = newIndex,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                RoundedButton(
                  text: widget.editPlayer ? 'Speichern' : 'Hinzufügen',
                  color: Colors.white,
                  textColor: Colors.black,
                  onTap: () async {
                    Player newPlayer = Player(
                      name: nameController.text,
                      character: selectedCharacter,
                      pointsHistory: [],
                    );

                    if (widget.editPlayer) {
                      Player player = playerData.players.firstWhere(
                          (player) => player.id == widget.playerToEditID!);

                      await playerData.editPlayer(
                        newPlayer.copy(
                          id: widget.playerToEditID,
                          pointsHistory: player.pointsHistory,
                          points: player.points,
                        ),
                      );
                    } else {
                      await playerData.addPlayer(newPlayer);
                    }

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectCharacter extends StatefulWidget {
  final int selectedCharacter;
  final Function(int) onChange;

  const SelectCharacter({
    Key? key,
    required this.onChange,
    this.selectedCharacter = 0,
  }) : super(key: key);

  @override
  State<SelectCharacter> createState() => _SelectCharacterState();
}

class _SelectCharacterState extends State<SelectCharacter> {
  int selectedCharacter = 0;

  @override
  void initState() {
    selectedCharacter = widget.selectedCharacter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (context, index) => CharacterSelectionCard(
        index: index,
        isSelected: index == selectedCharacter,
        onTap: () {
          setState(() {
            selectedCharacter = index;
            widget.onChange(index);
          });
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
    );
  }
}
