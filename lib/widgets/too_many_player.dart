import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';
import 'package:ligretto_counter/widgets/custom_dialog.dart';

import 'rounded_button_widget.dart';

class TooManyPlayers extends StatelessWidget {
  const TooManyPlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      content: Column(
        children: const [
          Text(
            'Maximale Spieleranzahl',
            textAlign: TextAlign.center,
            style: gameInformationHeadlineTextStyle,
          ),
          SizedBox(height: 10),
          Text(
            'Es können maximal 4 Spieler*innen hinzugefügt werden. Lösche Spieler*innen, um neue hinzufügen zu können.',
            textAlign: TextAlign.center,
            style: gameInformationTextStyle,
          )
        ],
      ),
      action: RoundedButton(
        text: 'Schließen',
        color: kRedColor,
        textColor: Colors.white,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
