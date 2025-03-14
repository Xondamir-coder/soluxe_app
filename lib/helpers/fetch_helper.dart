import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soluxe/constants/constants.dart';

enum HttpMethod { get, post }

class FetchHelper {
  static Future<Map<String, dynamic>> fetch({
    required String url,
    HttpMethod method = HttpMethod.get, // Use 'GET' or 'POST'
    Map<String, dynamic>? reqBody, // Only used for POST
    Map<String, dynamic>? queryParams, // Only used for GET
    String? token,
    String contentType = 'x-www-form-urlencoded', // Only used for POST
    String accept = 'json',
  }) async {
    try {
      // Parse the URL and add query parameters if it's a GET request.
      Uri uri = Uri.parse(url);
      if (method == HttpMethod.get && queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }

      late final http.Response res;

      if (method == HttpMethod.post) {
        res = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/$contentType',
            'Accept': 'application/$accept'
          },
          body: reqBody,
        );
      } else if (method == HttpMethod.get) {
        res = await http.get(
          uri,
          headers: {
            'Accept': 'application/$accept',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        );
      } else {
        throw Exception('Unsupported HTTP method: $method');
      }

      // Decode the JSON response.
      final body = json.decode(res.body);

      // Check for error status codes.
      if (res.statusCode > 201) {
        throw {
          'body': body,
          'code': res.statusCode,
        };
      }

      return body;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> sendCode(
      bool isEmail, String login) async {
    final endpoint = isEmail ? 'email-send' : 'sms-send';

    try {
      final body = await fetch(
        url: '${Constants.apiUrl}/$endpoint',
        method: HttpMethod.post,
        reqBody: {
          isEmail ? 'email' : 'phone': login,
        },
      );

      return body;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> verifyCode(
      bool isEmail, String login, String code) async {
    final endpoint = isEmail ? 'email-verify' : 'sms-verify';
    try {
      final body = await fetch(
        url: '${Constants.apiUrl}/$endpoint',
        method: HttpMethod.post,
        reqBody: {
          isEmail ? 'email' : 'phone': login,
          'verify_code': code,
        },
      );

      return body;
    } catch (e) {
      rethrow;
    }
  }
}
