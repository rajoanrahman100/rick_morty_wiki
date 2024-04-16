import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ricky_morty_wiki/core/constants/logger.dart';

import '../../core/constants/api_endpoints.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  Dio? _dio;

  static header() => {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-RapidAPI-Key": "7b4e17372bmshebc41281994c4f1p105934jsn2565dd226cfa",
        "X-RapidAPI-Host": "task-manager-api3.p.rapidapi.com"
      };

  Future<HttpService> init() async {
    _dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseGraphql, headers: header()));
    return this;
  }

  Future<dynamic> request({required String url, required Method method, params, String? authToken, context}) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio!.post(url, data: params!);
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else if (method == Method.PUT) {
        response = await _dio!.put(url, data: params);
      } else {
        response = await _dio!
            .get(url, queryParameters: params, options: Options(headers: {"Authorization": "Bearer $authToken"}));
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        //Get.offAll(const SignIn());
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 422) {
        //return Get.snackbar('Opps', response.data['message']);
      } else {
        throw Exception("Something does went wrong");
      }
    } on SocketException catch (e) {
      logger.e(e);

      throw Exception("No Internet Connection");
    } on FormatException catch (e) {
      logger.e(e);
      throw Exception("Bad response format");
    } on DioException catch (e) {
      logger.e(e);
      if (e.type == DioExceptionType.unknown) {
        log("Error Type unknown");

        throw Exception(e);
      } else if (e.type == DioExceptionType.cancel) {
        log("Error Type cancel");
        throw Exception(e);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        log("Error Type timedOut");
        throw Exception(e);
      } else if (e.type == DioExceptionType.receiveTimeout) {
        log("Error Type received timeout");
        throw Exception(e);
      } else if (e.type == DioExceptionType.sendTimeout) {
        log("Error Type send time out");
        throw Exception(e);
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 401) {
          log("Bad Response If");

          //Get.offAll(() => UserAuthenticationLandingScreen());
          throw Exception(e);
        } else {
          //InvalidLoginResponseModel invalidLoginResponseModel = InvalidLoginResponseModel.fromJson(e.response!.data);

          log("Bad Response Elseee");
          throw Exception(e);
        }
      }

      throw Exception(e);
    } catch (e) {
      logger.e(e);
      throw Exception("Something went wrong");
    }
  }
}
