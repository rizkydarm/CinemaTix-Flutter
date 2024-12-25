import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'network/dio.dart';
part 'network/endpoint.dart';
part 'network/api/my_api.dart';
part 'network/api/tmbd_api.dart';
part 'network/api/city_api.dart';

part 'util/theme.dart';
part 'util/env.dart';
part 'util/talker.dart';
part 'util/getit.dart';

part 'database/sql.dart';

final GetIt getit = GetItHelper.instance;