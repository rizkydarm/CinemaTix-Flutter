part of '../_core.dart';

class TalkerHelper {

  static final Talker instance = Talker(
    settings: TalkerSettings(
      enabled: true,
      useHistory: true,
      maxHistoryItems: 100,
      useConsoleLogs: true,
      colors: {
        TalkerLogType.httpResponse.key: AnsiPen()..red(),
        TalkerLogType.error.key: AnsiPen()..green(),
      },
    ),
  );
}