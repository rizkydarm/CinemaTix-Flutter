

import 'package:cinematix/domain/_domain.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

part 'stateful_value_builder.dart';
part 'bloc/favorite_button.dart';

void showLoadingHud(BuildContext context) {
  showGeneralDialog(
    context: context,
    useRootNavigator: true,
    routeSettings: const RouteSettings(name: 'loading'),
    barrierDismissible: false,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => const Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

void hideLoadingHud(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
