
import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cinematix/core/_core.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:cinematix/view/component/_component.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uuid/uuid.dart';

part 'home_page.dart';
part 'wallet_page.dart';
part 'search_page.dart';
part 'dashboard_nav_page.dart';
part 'movie_list_page.dart';
part 'movie_detail_page.dart';
part 'book_time_place_page.dart';
part 'login_page.dart';
part 'register_page.dart';
part 'seat_ticket_page.dart';
part 'checkout_page.dart';
part 'waiting_transaction_page.dart';