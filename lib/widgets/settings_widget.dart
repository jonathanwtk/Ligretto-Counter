import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';
import 'package:ligretto_counter/data/settings_data.dart';
import 'package:ligretto_counter/widgets/custom_dialog.dart';
import 'package:ligretto_counter/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../model/settings.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  SettingsData? settingsData;
  bool showPoints = false;

  @override
  void initState() {
    settingsData = context.read<SettingsData>();
    showPoints = settingsData!.settings.showPoints;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Einstellungen',
            style: gameInformationHeadlineTextStyle,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Punkte dauerhaft einblenden',
                style: gameInformationTextStyle,
              ),
              const SizedBox(height: 5),
              CupertinoSwitch(
                value: showPoints,
                onChanged: (newValue) {
                  setState(() {
                    showPoints = newValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      action: RoundedButton(
        text: 'Speichern',
        color: kRedColor,
        textColor: Colors.white,
        onTap: () async {
          await settingsData!.editSettings(Settings(showPoints: showPoints));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
