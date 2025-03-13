import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soluxe/constants/constants.dart';

class FetchHelper {
  static Future<Map<String, dynamic>> fetch({
    required String url,
    required Map<String, dynamic> reqBody,
    String? contentType = 'x-www-form-urlencoded',
    String? accept = 'json',
  }) async {
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/$contentType',
          'Accept': 'application/$accept'
        },
        body: reqBody,
      );
      final body = json.decode(res.body);

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
        url: '${Constants.baseUrl}/$endpoint',
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
        url: '${Constants.baseUrl}/$endpoint',
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
