import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../config/app_config.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';
import '../utils/logger.dart';

/// API client using http package for HTTP requests
class ApiClient {
  final http.Client _client;
  final GetStorage _storage = GetStorage();
  final String _baseUrl;
  final Duration _connectTimeout;
  final Duration _receiveTimeout;
  
  ApiClient({
    http.Client? client,
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? AppConfig.apiBaseUrl,
        _connectTimeout = connectTimeout ?? Duration(milliseconds: AppConfig.connectTimeout),
        _receiveTimeout = receiveTimeout ?? Duration(milliseconds: AppConfig.receiveTimeout);
  
  /// Get default headers
  Map<String, String> _getHeaders({Map<String, String>? additionalHeaders}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    // Add auth token if available
    final token = _storage.read<String>(AppConstants.tokenKey);
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    // Add any additional headers
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    
    return headers;
  }
  
  /// Build full URL
  Uri _buildUri(String path, Map<String, dynamic>? queryParameters) {
    final uri = Uri.parse(_baseUrl + path);
    if (queryParameters != null && queryParameters.isNotEmpty) {
      return uri.replace(queryParameters: queryParameters.map(
        (key, value) => MapEntry(key, value.toString()),
      ));
    }
    return uri;
  }
  
  /// Handle HTTP errors and convert to app exceptions
  AppException _handleError(http.Response response) {
    final statusCode = response.statusCode;
    String message = 'Server error occurred';
    
    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      message = json['message'] as String? ?? message;
    } catch (e) {
      // If response is not JSON, use status code message
      message = response.reasonPhrase ?? message;
    }
    
    return ServerException(message, statusCode: statusCode);
  }
  
  /// Handle network errors
  AppException _handleNetworkError(dynamic error) {
    if (error is http.ClientException) {
      return NetworkException('No internet connection. Please check your network.');
    }
    if (error is FormatException) {
      return ServerException('Invalid response format from server');
    }
    return NetworkException('Connection error. Please try again.');
  }
  
  /// GET request
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(path, queryParameters);
      final requestHeaders = _getHeaders(additionalHeaders: headers);
      
      AppLogger.d('Request: GET $uri');
      
      final response = await _client
          .get(uri, headers: requestHeaders)
          .timeout(_receiveTimeout);
      
      AppLogger.d('Response: ${response.statusCode} $path');
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse(
          statusCode: response.statusCode,
          body: response.body,
          headers: response.headers,
        );
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      if (e is AppException) rethrow;
      AppLogger.e('GET Error: $e');
      throw _handleNetworkError(e);
    }
  }
  
  /// POST request
  Future<ApiResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(path, queryParameters);
      final requestHeaders = _getHeaders(additionalHeaders: headers);
      final body = data != null ? jsonEncode(data) : null;
      
      AppLogger.d('Request: POST $uri');
      
      final response = await _client
          .post(uri, headers: requestHeaders, body: body)
          .timeout(_receiveTimeout);
      
      AppLogger.d('Response: ${response.statusCode} $path');
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse(
          statusCode: response.statusCode,
          body: response.body,
          headers: response.headers,
        );
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      if (e is AppException) rethrow;
      AppLogger.e('POST Error: $e');
      throw _handleNetworkError(e);
    }
  }
  
  /// PUT request
  Future<ApiResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(path, queryParameters);
      final requestHeaders = _getHeaders(additionalHeaders: headers);
      final body = data != null ? jsonEncode(data) : null;
      
      AppLogger.d('Request: PUT $uri');
      
      final response = await _client
          .put(uri, headers: requestHeaders, body: body)
          .timeout(_receiveTimeout);
      
      AppLogger.d('Response: ${response.statusCode} $path');
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse(
          statusCode: response.statusCode,
          body: response.body,
          headers: response.headers,
        );
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      if (e is AppException) rethrow;
      AppLogger.e('PUT Error: $e');
      throw _handleNetworkError(e);
    }
  }
  
  /// DELETE request
  Future<ApiResponse> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(path, queryParameters);
      final requestHeaders = _getHeaders(additionalHeaders: headers);
      final body = data != null ? jsonEncode(data) : null;
      
      AppLogger.d('Request: DELETE $uri');
      
      final response = await _client
          .delete(uri, headers: requestHeaders, body: body)
          .timeout(_receiveTimeout);
      
      AppLogger.d('Response: ${response.statusCode} $path');
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse(
          statusCode: response.statusCode,
          body: response.body,
          headers: response.headers,
        );
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      if (e is AppException) rethrow;
      AppLogger.e('DELETE Error: $e');
      throw _handleNetworkError(e);
    }
  }
  
  /// Close the HTTP client
  void close() {
    _client.close();
  }
}

/// API Response wrapper to maintain compatibility with existing code
class ApiResponse {
  final int statusCode;
  final String body;
  final Map<String, String> headers;
  
  ApiResponse({
    required this.statusCode,
    required this.body,
    required this.headers,
  });
  
  /// Get response data as JSON
  dynamic get data {
    try {
      return jsonDecode(body);
    } catch (e) {
      return null;
    }
  }
  
  /// Get response data as Map
  Map<String, dynamic>? get dataAsMap {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  /// Get response data as List
  List<dynamic>? get dataAsList {
    try {
      final decoded = jsonDecode(body);
      if (decoded is List) {
        return decoded;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
