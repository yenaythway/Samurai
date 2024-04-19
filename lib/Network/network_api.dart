import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:real_time_chatting/Network/app_exeptions.dart';
import 'package:real_time_chatting/Network/base_api_services.dart';
import 'package:real_time_chatting/Utils/super_print.dart';

class NetworkApi extends BaseAPIServices {
  bool isJson(String str) {
    try {
      json.decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<http.Response> getApiResponse({required String url}) async {
    final StackTrace stackTrace = StackTrace.current;
    final List<String> frames = stackTrace.toString().split("\n");
    String callerFrame = frames[1];
    superPrint(url,
        title: 'Get Url - ${callerFrame.split('(').last.replaceAll(')', '')}');
    try {
      http.Response httpResponse = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        'Content-type': 'application/json',
      });

      http.Response response = http.Response(
        isJson(httpResponse.body)
            ? json.decode(utf8.decode(httpResponse.bodyBytes))
            : httpResponse.body,
        httpResponse.statusCode,
        headers: httpResponse.headers,
      );
      http.Response responseJson = returnResponse(response);
      superPrint(responseJson.body,
          title:
              'getApiResponse responseJson - ${callerFrame.split('(').last.replaceAll(')', '')}');
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<http.Response> postApiResponse(
      {required String url, required dynamic data}) async {
    final StackTrace stackTrace = StackTrace.current;
    final List<String> frames = stackTrace.toString().split("\n");
    String callerFrame = frames[1];
    superPrint(url,
        title: 'Post Url - ${callerFrame.split('(').last.replaceAll(')', '')}');
    superPrint(json.encode(data),
        title:
            'Post data - ${callerFrame.split('(').last.replaceAll(')', '')}');
    try {
      http.Response httpResponse = await http
          .post(Uri.parse(url),
              headers: {
                "Accept": "application/json",
                'Content-type': 'application/json',
              },
              body: json.encode(data))
          .timeout(const Duration(minutes: 2));
      http.Response response = http.Response(
        isJson(httpResponse.body)
            ? json.decode(utf8.decode(httpResponse.bodyBytes))
            : httpResponse.body,
        httpResponse.statusCode,
        headers: httpResponse.headers,
      );
      http.Response responseJson = returnResponse(response);
      superPrint(responseJson.body,
          title:
              'postApiResponse responseJson - ${callerFrame.split('(').last.replaceAll(')', '')}');
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      throw Exception(e);
    }
  }

  http.Response returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        http.Response responseJson = response;
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 404:
        throw UnauthorizedException(response.body);
      default:
        throw FetchDataException(
            "Error occured while communicating with server with status code ${response.statusCode}");
    }
  }
}
