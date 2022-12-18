import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';
import 'package:ligretto_counter/data/settings_data.dart';
import 'package:ligretto_counter/widgets/content_box_widget.dart';
import 'package:ligretto_counter/widgets/custom_dialog.dart';
import 'package:ligretto_counter/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../model/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF941912),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: Column(
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
                      'Einstellungen',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
              ),
              const Spacer(),
              RoundedButton(
                text: 'Speichern',
                color: Colors.white,
                textColor: Colors.black,
                onTap: () async {
                  await settingsData!
                      .editSettings(Settings(showPoints: showPoints));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
