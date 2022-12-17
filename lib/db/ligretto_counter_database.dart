import 'package:ligretto_counter/model/game_informations.dart';
import 'package:ligretto_counter/model/player.dart';
import 'package:ligretto_counter/model/points.dart';
import 'package:ligretto_counter/model/settings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class LigrettoCounterDatabase extends ChangeNotifier {
  static final LigrettoCounterDatabase instance =
      LigrettoCounterDatabase._init();

  static Database? _database;

  LigrettoCounterDatabase._init();

  //DB getter
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('player.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const optionalIntegerType = 'INTEGER';

    await db.execute('''
CREATE TABLE $tablePlayer (
  ${PlayerFields.id} $idType,
  ${PlayerFields.name} $textType,
  ${PlayerFields.character} $integerType,
  ${PlayerFields.points} $integerType,
  ${PlayerFields.lastRoundScore} $integerType
  )
  ''');

    await db.execute('''
CREATE TABLE $tablePoints (
  ${PointsFields.id} $idType,
  ${PointsFields.playerID} $integerType,
  ${PointsFields.points} $integerType,
  ${PointsFields.roundIndex} $integerType
  )
  ''');

    await db.execute('''
CREATE TABLE $tableSettings (
  ${SettingsFields.id} $idType,
  ${SettingsFields.showPoints} $integerType
  )
  ''');

    await db.execute('''
CREATE TABLE $tableGameInformations (
  ${GameInformationsFields.id} $idType,
  ${GameInformationsFields.roundNumber} $integerType,
  ${GameInformationsFields.winnerID} $optionalIntegerType
  )
  ''');

    //Inittialize settings
    db.rawInsert(
      '''
      INSERT INTO $tableSettings(
      ${SettingsFields.showPoints}
    ) VALUES(
      ?
    )
    ''',
      [
        0,
      ],
    );

    //Inittialize GameInformations
    db.rawInsert(
      '''
      INSERT INTO $tableGameInformations(
      ${GameInformationsFields.roundNumber},
      ${GameInformationsFields.winnerID}
    ) VALUES(
      ?,
      ?
    )
    ''',
      [
        0,
        0,
      ],
    );
  }

  Future<Player> create(Player player) async {
    final db = await instance.database;

    final id = await db.insert(tablePlayer, player.toJson());
    return player.copy(id: id);
  }

  Future<Points> createPoints(Points points) async {
    final db = await instance.database;

    final id = await db.insert(tablePoints, points.toJson());
    return points.copy(id: id);
  }

  Future<Player> readPlayer(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePlayer,
      columns: PlayerFields.values,
      where: '${PlayerFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Player.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Points>> readPoints({
    required String where,
    required List<Object> whereArgs,
  }) async {
    final db = await instance.database;

    final result = await db.query(
      tablePoints,
      columns: PointsFields.values,
      where: where,
      whereArgs: whereArgs,
    );

    return result.map((json) => Points.fromJson(json)).toList();
  }

  Future<Settings> readSettings() async {
    final db = await instance.database;

    final maps = await db.query(tableSettings);

    return maps.map((json) => Settings.fromJson(json)).toList().first;
  }

  Future<GameInformations> readGameInformations() async {
    final db = await instance.database;

    final maps = await db.query(tableGameInformations);

    return maps.map((json) => GameInformations.fromJson(json)).toList().first;
  }

  Future<List<Player>> readAllPlayer() async {
    final db = await instance.database;

    final result = await db.query(tablePlayer);

    List<Player> toReturn = [];

    for (var json in result) {
      toReturn.add(await Player.fromJson(json));
    }

    return toReturn;
  }

  Future<int> update(Player player) async {
    final db = await instance.database;

    return db.update(
      tablePlayer,
      player.toJson(),
      where: '${PlayerFields.id} = ?',
      whereArgs: [player.id],
    );
  }

  Future<void> updateSettings(Settings newSettings) async {
    final db = await instance.database;

    await db.update(
      tableSettings,
      newSettings.toJson(),
      where: '${SettingsFields.id} = ?',
      whereArgs: [newSettings.id],
    );
  }

  Future<void> updateGameInformations(
      GameInformations newGameInformations) async {
    final db = await instance.database;

    await db.update(
      tableGameInformations,
      newGameInformations.toJson(),
      where: '${GameInformationsFields.id} = ?',
      whereArgs: [newGameInformations.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tablePlayer,
      where: '${PlayerFields.id} = ?',
      whereArgs: [id],
    );
    //TODO: delete Player from GameInformations
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
