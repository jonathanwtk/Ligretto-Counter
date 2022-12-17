const String tableSettings = 'settings';

class SettingsFields {
  static final List<String> values = [id, showPoints];

  static const String id = '_id';
  static const String showPoints = 'showPoints';
}

class Settings {
  final int? id;
  final bool showPoints;

  const Settings({
    this.id,
    required this.showPoints,
  });

  Settings copy({int? id, bool? showPoints}) => Settings(
        id: id ?? this.id,
        showPoints: showPoints ?? this.showPoints,
      );

  static Settings fromJson(Map<String, Object?> json) => Settings(
        id: json[SettingsFields.id] as int?,
        showPoints: json[SettingsFields.showPoints] == 1,
      );

  Map<String, Object?> toJson() => {
        SettingsFields.id: id,
        SettingsFields.showPoints: showPoints ? 1 : 0,
      };
}
