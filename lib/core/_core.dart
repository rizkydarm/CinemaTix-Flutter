import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'network/dio.dart';
part 'network/endpoint.dart';
part 'network/api/my_api.dart';
part 'network/api/tmbd_api.dart';
part 'network/api/city_api.dart';

part 'network/firebase/push_notification.dart';

part 'util/theme.dart';
part 'util/env.dart';
part 'util/talker.dart';
part 'util/getit.dart';

part 'database/sql.dart';
part 'database/shared_pref.dart';

final GetIt getit = GetItHelper.instance;

String intToIdr(num number) {
  final format = NumberFormat.currency(locale: 'ID', decimalDigits: 0);
  return format.format(number);
}

String generateLongString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => chars.codeUnitAt(random.nextInt(chars.length)),
  ));
}

String generateRandomNumberString(int length) {
  final random = Random();
  final digits = List.generate(length, (_) => random.nextInt(10).toString()).join();
  return digits;
}