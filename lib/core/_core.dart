import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

part 'network/dio.dart';
part 'network/api/my_api.dart';
part 'network/api/tmbd_api.dart';
part 'network/endpoint.dart';

part 'util/theme.dart';
part 'util/env.dart';
part 'util/talker.dart';

final Talker talker = TalkerHelper.instance;