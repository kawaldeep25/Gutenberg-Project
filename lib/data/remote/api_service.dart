import 'dart:async';

// import 'package:guten/data/local/jwtParser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:guten/data/model/api_response.dart';
import 'package:guten/data/model/books_list.dart';
import 'package:guten/data/remote/dio_error_util.dart';
import 'package:guten/data/remote/remote_data_source.dart';
import 'package:guten/utils/constants/constants.dart';

class ApiService implements RemoteDataSource {
  static const String jwt = 'Bearer ';
  static const String authorization = 'Authorization';
  final _dio = dio.Dio(
    dio.BaseOptions(
      // baseUrl: 'https://' + Constants.URL,
      baseUrl: Constants.BASEURL,

      contentType: dio.Headers.jsonContentType,
      connectTimeout: 60000,
      receiveTimeout: 60000,
      // headers: {
      //   'Content-Type': 'application/json',
      // },
    ),
  )..interceptors.add(dio.LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  ApiService();

  @override
  Future<ApiResponse<BookList>?> getBooks(String category) async {
    // TODO: implement getbooks
    try {
      final response = await _dio.get(
        '/books',
        queryParameters: {'mime_type': 'image', 'topic': category},
        options: dio.Options(
            // headers: {
            //   authorization: "Basic " + token,
            // },
            ),
      );

      return ApiResponse<BookList>(
        success: response.data['success'],
        message: response.data['message'],
        status: response.statusCode,
        data: BookList.fromJson(response.data),
      );
    } catch (error, stackTrace) {
      if (error is DioError) {
        final dio.DioError dioError = error;

        return ApiResponse<BookList>(
            success: false,
            message: DioErrorUtil.handleError(error) != ""
                ? DioErrorUtil.handleError(error)
                : dioError.response!.data['message'],
            status:
                dioError.response != null ? dioError.response!.statusCode : 400,
            data: null);
      }
    }
  }

  @override
  Future<ApiResponse<BookList>?> getMoreBooks(
      String category, int page, String? key) async {
    // TODO: implement getbooks
    try {
      final response = await _dio.get(
        '/books',
        queryParameters: {
          'mime_type': 'image',
          'topic': category,
          'page': page,
          'search': key
        },
        options: dio.Options(
            // headers: {
            //   authorization: "Basic " + token,
            // },
            ),
      );

      return ApiResponse<BookList>(
        success: response.data['success'],
        message: response.data['message'],
        status: response.statusCode,
        data: BookList.fromJson(response.data),
      );
    } catch (error, stackTrace) {
      if (error is DioError) {
        final dio.DioError dioError = error;

        return ApiResponse<BookList>(
            success: false,
            message: DioErrorUtil.handleError(error) != ""
                ? DioErrorUtil.handleError(error)
                : dioError.response!.data['message'],
            status:
                dioError.response != null ? dioError.response!.statusCode : 400,
            data: null);
      }
    }
  }

  @override
  Future<ApiResponse<BookList>?> getBookBySearch(
      String category, String? key) async {
    // TODO: implement getbooks
    try {
      final response = await _dio.get(
        '/books',
        queryParameters: {
          'mime_type': 'image',
          'topic': category,
          'search': key
        },
        options: dio.Options(
            // headers: {
            //   authorization: "Basic " + token,
            // },
            ),
      );

      return ApiResponse<BookList>(
        success: response.data['success'],
        message: response.data['message'],
        status: response.statusCode,
        data: BookList.fromJson(response.data),
      );
    } catch (error, stackTrace) {
      if (error is DioError) {
        final dio.DioError dioError = error;

        return ApiResponse<BookList>(
            success: false,
            message: DioErrorUtil.handleError(error) != ""
                ? DioErrorUtil.handleError(error)
                : dioError.response!.data['message'],
            status:
                dioError.response != null ? dioError.response!.statusCode : 400,
            data: null);
      }
    }
  }

  @override
  Future<ApiResponse<BookItem>?> getBookDetails(
      String category, String id) async {
    // TODO: implement getbooks
    try {
      final response = await _dio.get(
        '/books/$id',
        options: dio.Options(
            // headers: {
            //   authorization: "Basic " + token,
            // },
            ),
      );

      return ApiResponse<BookItem>(
        success: response.data['success'],
        message: response.data['message'],
        status: response.statusCode,
        data: BookItem.fromJson(response.data),
      );
    } catch (error, stackTrace) {
      if (error is DioError) {
        final dio.DioError dioError = error;

        return ApiResponse<BookItem>(
            success: false,
            message: DioErrorUtil.handleError(error) != ""
                ? DioErrorUtil.handleError(error)
                : dioError.response!.data['message'],
            status:
                dioError.response != null ? dioError.response!.statusCode : 400,
            data: null);
      }
    }
  }
}
