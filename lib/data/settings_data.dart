import 'package:flutter/material.dart';

import '../db/ligretto_counter_database.dart';
import '../model/settings.dart';

class SettingsData with ChangeNotifier {
  Settings settings = const Settings(showPoints: false);

  Future editSettings(Settings newSettings) async {
    await LigrettoCounterDatabase.instance.updateSettings(
      settings.copy(showPoints: newSettings.showPoints),
    );
    settings = newSettings;

    notifyListeners();
  }
}
