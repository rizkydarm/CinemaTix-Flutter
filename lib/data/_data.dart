import 'dart:convert';

import 'package:cinematix/core/_core.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uuid/uuid.dart';

part 'models/movie_model.dart';
part 'models/movie_detail_model.dart';
part 'models/movie_credit_model.dart';
part 'models/profile_model.dart';
part 'models/user_model.dart';
part 'models/all_cities_model.dart';
part 'models/favorite_movie_model.dart';
part 'models/transaction_model.dart';

part 'remote_data_sources/remote_data_source.dart';
part 'remote_data_sources/movie_data_source.dart';
part 'remote_data_sources/city_data_source.dart';
part 'remote_data_sources/firebase_auth_data_source.dart';

part 'local_data_sources/local_data_source.dart';
part 'local_data_sources/favorite_movie_data_source.dart';
part 'local_data_sources/auth_data_source.dart';
part 'local_data_sources/transaction_data_source.dart';

part 'repositories/repository.dart';
part 'repositories/movie_repository.dart';
part 'repositories/city_repository.dart';
part 'repositories/auth_repository.dart';
part 'repositories/favorite_movie_repository.dart';
part 'repositories/transaction_repository.dart';