part of '../_core.dart';

class Endpoint {
  final String url;
  final Map<String, dynamic> headers;
  final Map<String, dynamic>? params;
  final Object? data;
  
  const Endpoint(this.url, this.headers, {this.params, this.data});
}