import 'dart:convert';

import 'package:http/http.dart' as http;

class Response {
  final int? code;
  final bool success;
  final dynamic data;
  final String? error;

  Response({this.code, required this.success, this.data, this.error});

  factory Response.success(dynamic data) => Response(success: true, data: data);
  factory Response.error(int code, String message) => Response(code: code, success: false, error: message);
}

class ApiService {
  static const String _apiURL = "localhost:3000";

  static Future<Response> _request(
      String method,
      String endpoint, {
        String? token,
        Map<String, dynamic>? body,
      }) async {
    var url = Uri.http(_apiURL, endpoint);
    try {
      var headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token"
      };

      var request = http.Request(method, url)
        ..headers.addAll(headers);

      if (body != null) {
        request.body = jsonEncode(body);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Response.success(jsonDecode(response.body));
      }

      return Response.error(response.statusCode, _parseError(response.body));
    } catch (e) {
      return Response.error(503, "API hiba: $e");
    }
  }

  static Future<Response> postRequest(String endpoint, String? token, Map<String, dynamic> body) =>
      _request("POST", endpoint, token: token, body: body);

  static Future<Response> getRequest(String endpoint, String token) =>
      _request("GET", endpoint, token: token);

  static Future<Response> patchRequest(String endpoint, String token, Map<String, dynamic> body) =>
      _request("PATCH", endpoint, token: token, body: body);

  static Future<Response> putRequest(String endpoint, String token, Map<String, dynamic> body) =>
      _request("PUT", endpoint, token: token, body: body);

  static String _parseError(String responseBody) {
    try {
      final decoded = jsonDecode(responseBody);
      return decoded["message"] ?? "Ismeretlen hiba";
    } catch (e) {
      return "Hibás válasz formátum";
    }
  }
}
