import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class ApiClient {
  static const String baseUrl = 'https://edutrack-9srw.onrender.com/api';
  late final Dio dio;
  final CookieJar cookieJar = CookieJar();

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (status) => status != null && status < 500,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Persist session cookies across all API calls automatically
    dio.interceptors.add(CookieManager(cookieJar));
  }

  // --- 1. AUTHENTICATION ---
  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    final response = await dio.post('/auth/login', data: {
      'identifier': identifier.trim(),
      'password': password,
    });

    if (response.statusCode == 200 && response.data['ok'] == true) {
      return response.data;
    } else {
      throw Exception(response.data['error'] ?? 'Authentication failed');
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final response = await dio.get('/auth/me');
    if (response.statusCode == 200 && response.data['user'] != null) {
      return response.data['user'];
    }
    return null;
  }

  Future<void> logout() async {
    await dio.post('/auth/logout');
    await cookieJar.deleteAll();
  }

  // --- 2. GPS & GEOFENCE ATTENDANCE ---
  Future<Map<String, dynamic>> submitGeofenceAttendance({
    required double latitude,
    required double longitude,
  }) async {
    final response = await dio.post('/attendance/check-in', data: {
      'lat': latitude,
      'lng': longitude,
    });
    return response.data;
  }

  // --- 3. DYNAMIC TIMETABLE ---
  Future<List<dynamic>> getTimetable({
    required String department,
    required String dayOfWeek,
  }) async {
    final response = await dio.get('/timetable/grid', queryParameters: {
      'department': department,
      'day': dayOfWeek,
    });
    if (response.statusCode == 200 && response.data['entries'] != null) {
      return response.data['entries'];
    }
    return [];
  }

  // --- 4. EARLY WARNING SYSTEM (EWS) ---
  Future<List<dynamic>> getEwsAlerts() async {
    final response = await dio.get('/ews/alerts');
    if (response.statusCode == 200 && response.data['alerts'] != null) {
      return response.data['alerts'];
    }
    return [];
  }
}
