part of '../_core.dart';

class Env {
  static bool get isProd => FlavorConfig.instance.name == 'PROD';
  static bool get isDev => FlavorConfig.instance.name == 'DEV';
  static bool get isUat => FlavorConfig.instance.name == 'UAT';
}