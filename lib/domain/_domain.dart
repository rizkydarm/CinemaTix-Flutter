
import 'package:cinematix/core/_core.dart';
import 'package:cinematix/data/_data.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'entities/movie_entity.dart';
part 'entities/searched_movie_entity.dart';
part 'entities/movie_detail_entity.dart';
part 'entities/movie_credit_entity.dart';
part 'entities/cinema_mall_entity.dart';
part 'entities/profile_entity.dart';
part 'entities/user_entity.dart';
part 'entities/favorite_movie_entity.dart';
part 'entities/transaction_entity.dart';

part 'usecases/movie_usecase.dart';
part 'usecases/city_usecase.dart';
part 'usecases/auth_usecase.dart';
part 'usecases/favorite_movie_usecase.dart';
part 'usecases/transaction_usecase.dart';

abstract class Entity extends Equatable {}