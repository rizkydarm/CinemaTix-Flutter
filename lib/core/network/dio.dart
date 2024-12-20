part of '../_core.dart';

class DioHelper {
  
  final Dio _dio;

  DioHelper(String baseUrl) : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    )
  ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('**Request**');
          debugPrint('\t${options.path}');
          // debugPrint(options.data.toString());
          // debugPrint(options.headers.toString());
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // debugPrint('==Response==');
          // debugPrint(response.statusMessage);
          // debugPrint(response.data.toString());
          // debugPrint(response.statusCode.toString());
          return handler.next(response);
        } ,
        onError: (e, handler) {
          debugPrint('##Error##');
          debugPrint("${e.message}: ${e.response?.statusCode}");
          debugPrint(e.response?.statusMessage);
          // debugPrint(e.response?.data.toString());
          return handler.next(e);
        },
      ),
    );
    _dio.interceptors.add(TalkerDioLogger(
        talker: talker,
      ),);
  }
  
  Future<T?> get<T>(Endpoint endpoint) async {
    try {
      final response = await _dio.get<T>(endpoint.url, 
        queryParameters: endpoint.params, 
        options: Options(
          headers: endpoint.headers
        )
      );
      return response.data;
    } on DioException catch (e) {
      final exp = _dioError(e);
      throw exp;
    } catch (e) {
      rethrow;
    } 
  }

  Future<T?> post<T>(Endpoint endpoint) async {
    try {
      final response = await _dio.post<T>(endpoint.url, 
        data: endpoint.data, 
        queryParameters: endpoint.params,
        options: Options(
          headers: endpoint.headers
        )
      );
      return response.data;
    } on DioException catch (e) {
      final exp = _dioError(e);
      throw exp;
    } catch (e) {
      rethrow;
    } 
  }

  Exception _dioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception("Connection Timeout Exception");
    } else if (e.type == DioExceptionType.sendTimeout) {
      return Exception("Send Timeout Exception");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return Exception("Receive Timeout Exception");
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final statusMessage = e.response?.statusMessage;
      return Exception("Received invalid status code: $statusCode, Message: $statusMessage");
    } else if (e.type == DioExceptionType.cancel) {
      throw Exception("Request to API server was cancelled");
    } else if (e.type == DioExceptionType.unknown) {
      return Exception("Network Error: ${e.message}");
    } else {
      return Exception("Null Error");
    }
  }
}