import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/storage_service.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class ApiClient {
  final StorageService _storageService;

  ApiClient(this._storageService);

  Future<Map<String, String>> _buildHeaders({bool withAuth = false}) async {
    final headers = {'Content-Type': 'application/json'};
    if (withAuth) {
      final token = await _storageService.getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<dynamic> get(String url, {bool withAuth = false}) async {
    try {
      final headers = await _buildHeaders(withAuth: withAuth);
      final response = await http.get(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw ApiException('Something went wrong. Please check your connection.');
    }
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? body, bool withAuth = false}) async {
    try {
      final headers = await _buildHeaders(withAuth: withAuth);
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException('Something went wrong. Please check your connection.');
    }
  }

  dynamic _handleResponse(http.Response response) {
    final decoded = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    } else {
      final message = decoded is Map && decoded['message'] != null
          ? decoded['message'].toString()
          : 'Request failed (${response.statusCode})';
      throw ApiException(message);
    }
  }
}