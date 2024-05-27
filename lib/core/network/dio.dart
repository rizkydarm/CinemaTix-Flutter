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
          debugPrint(options.path);
          // debugPrint(options.data.toString());
          // debugPrint(options.headers.toString());
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('==Response==');
          debugPrint(response.statusMessage);
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
      throw e.response?.statusMessage ?? Exception("Error is null");
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
      throw e.response?.statusMessage ?? Exception("Error is null");
    } catch (e) {
      rethrow;
    } 
  }
}