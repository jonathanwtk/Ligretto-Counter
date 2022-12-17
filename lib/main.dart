import 'package:flutter/material.dart';
import 'package:ligretto_counter/data/game_informations_data.dart';
import 'package:ligretto_counter/data/player_data.dart';
import 'package:ligretto_counter/data/settings_data.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerData()),
        ChangeNotifierProvider(create: (_) => SettingsData()),
        ChangeNotifierProvider(create: (_) => GameInformationsData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
