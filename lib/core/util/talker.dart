part of '../_core.dart';

class TalkerHelper {

  TalkerHelper._();

  static final Talker instance = TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: true,
      useHistory: true,
      maxHistoryItems: 100,
      useConsoleLogs: true,
      colors: {
        TalkerLogType.httpResponse.name: AnsiPen()..red(),
        TalkerLogType.error.name: AnsiPen()..green(),
      },
    ),
  );
}