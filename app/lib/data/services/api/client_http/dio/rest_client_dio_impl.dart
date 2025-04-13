import '../../../../../core/constants/env.dart';
import 'client_interceptor_dio_impl.dart';
import 'dio_adapter.dart';
import '../i_client_interceptor.dart';
import '../i_rest_client.dart';
import '../rest_client_multipart.dart';
import '../rest_client_request.dart';
import '../rest_client_response.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class DioFactory {
  static Dio dio() {
    final baseOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
    ).copyWith(baseUrl: baseUrl);
    return Dio(baseOptions);
  }
}

class RestClientDioImpl implements IRestClient {
  final Dio _dio;

  final Map<IClientInterceptor, Interceptor> _interceptors = {};

  RestClientDioImpl({required Dio dio}) : _dio = dio;

  @override
  void addInterceptors(IClientInterceptor interceptor) {
    _interceptors[interceptor] = ClientInterceptorDioImpl(
      interceptor: interceptor,
    );
    _dio.interceptors.add(_interceptors[interceptor]!);
  }

  @override
  void removeInterceptors(IClientInterceptor interceptor) {
    _dio.interceptors.remove(_interceptors[interceptor]);
  }

  @override
  AsyncResult<RestClientResponse> upload(RestClientMultipart multipart) async {
    final formData = FormData.fromMap({
      multipart.fileKey: MultipartFile.fromBytes(
        multipart.fileBytes ?? [],
        filename: multipart.fileName,
      ),
    });

    final baseOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
    );

    try {
      Dio dio = Dio(baseOptions);
      final response = await dio.put(multipart.path, data: formData);

      return Success(DioAdapter.toClientResponse(response));
    } on DioException catch (e) {
      return Failure(DioAdapter.toClientException(e));
    }
  }

  @override
  AsyncResult<RestClientResponse> delete(RestClientRequest request) async {
    try {
      final response = await _dio.delete(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return Success(DioAdapter.toClientResponse(response));
    } on DioException catch (e) {
      return Failure(DioAdapter.toClientException(e));
    }
  }

  @override
  AsyncResult<RestClientResponse> get(RestClientRequest request) async {
    try {
      final response = await _dio.get(
        request.path,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
        cancelToken: request.cancelRequest?.token,
      );
      return Success(DioAdapter.toClientResponse(response));
    } on DioException catch (e) {
      return Failure(DioAdapter.toClientException(e));
    }
  }

  @override
  AsyncResult<RestClientResponse> patch(RestClientRequest request) async {
    try {
      final response = await _dio.patch(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return Success(DioAdapter.toClientResponse(response));
    } on DioException catch (e) {
      return Failure(DioAdapter.toClientException(e));
    }
  }

  @override
  AsyncResult<RestClientResponse> post(RestClientRequest request) async {
    try {
      final response = await _dio.post(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return Success(DioAdapter.toClientResponse(response));
    } on DioException catch (e) {
      return Failure(DioAdapter.toClientException(e));
    }
  }

  @override
  AsyncResult<RestClientResponse> put(RestClientRequest request) async {
    try {
      final response = await _dio.put(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return Success(DioAdapter.toClientResponse(response));
    } on DioException catch (e) {
      return Failure(DioAdapter.toClientException(e));
    }
  }
}
