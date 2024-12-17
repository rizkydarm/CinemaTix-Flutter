part of '../_core.dart';

class TalkerHelper {

  static final Talker instance = Talker(
    settings: TalkerSettings(
      /// You can enable/disable all talker processes with this field
      enabled: true,
      /// You can enable/disable saving logs data in history
      useHistory: true,
      /// Length of history that saving logs data
      maxHistoryItems: 100,
      /// You can enable/disable console logs
      useConsoleLogs: true,
      colors: {
        TalkerLogType.httpResponse.key: AnsiPen()..red(),
        TalkerLogType.error.key: AnsiPen()..green(),
      },
    ),
  );
}