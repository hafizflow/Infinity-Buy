import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:infinity_buy/presentation/state_holders/auth_controller.dart';

import '../models/response_data.dart';

class NetworkCaller {
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log("Url: $url");
    log("token: ${token.toString()}");

    final Response response = await get(Uri.parse(url), headers: {
      'token': token.toString(),
      'Content-type': 'application/json',
    });

    if (response.statusCode == 200) {
      // for better understanding
      log("StatusCode: ${response.statusCode.toString()}");
      log("Body: ${response.body.toString()}");

      // decode json response into dart
      final decodedResponse = jsonDecode(response.body);

      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }

  Future<ResponseData> postRequest(String url,
      {Map<String, dynamic>? body, String? token}) async {
    log(url);
    log(body.toString());

    final Response response =
        await post(Uri.parse(url), body: jsonEncode(body), headers: {
      'token': AuthController.token.toString(),
      'Content-type': 'application/json',
    });

    log(response.statusCode.toString());
    log(response.body.toString());

    if (response.statusCode == 200) {
      // decode json response into dart
      final decodedResponse = jsonDecode(response.body);

      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }
}
