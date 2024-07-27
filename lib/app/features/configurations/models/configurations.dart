class Configurations {
  bool darkMode;

  Configurations({required this.darkMode});

  Configurations.empty() : darkMode = false;

  Configurations.fromJson(Map<String, dynamic> json)
      : darkMode = json['dark_mode'] == 1 ? true : false;

  Map<String, Object?> toJson() => {"dark_mode": darkMode ? 1 : 0};
}
