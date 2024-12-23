
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
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

part 'home_page.dart';
part 'wallet_page.dart';
part 'search_page.dart';
part 'dashboard_nav_page.dart';
part 'movie_list_page.dart';
part 'movie_detail_page.dart';
part 'book_time_place_page.dart';