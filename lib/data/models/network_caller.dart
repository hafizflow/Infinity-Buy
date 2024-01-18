import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../services/response_data.dart';

class NetworkCaller {
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log(url);

    final Response response = await get(Uri.parse(url), headers: {
      'token': token.toString(),
      'Content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      // for better understanding
      log(response.statusCode.toString());
      log(response.body.toString());

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
      {Map<String, dynamic>? body}) async {
    log(url);
    log(body.toString());

    final Response response =
        await post(Uri.parse(url), body: jsonEncode(body));

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
