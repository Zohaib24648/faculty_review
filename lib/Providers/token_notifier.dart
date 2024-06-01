import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenNotifier extends StateNotifier<String?> {
  static const _storageKey = 'jwt_token';
  final FlutterSecureStorage _storage;
  late final Future<void> _initialized;

  TokenNotifier(this._storage) : super(null) {
    _initialized = _loadToken();
  }

  Future<void> _loadToken() async {
    try {
      final token = await _storage.read(key: _storageKey);
      if (token != null) {
        state = token;
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> setToken(String token) async {
    try {
      state = token;
      await _storage.write(key: _storageKey, value: token);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> clearToken() async {
    try {
      state = null;
      await _storage.delete(key: _storageKey);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> get initialized => _initialized;
}

final tokenProvider = StateNotifierProvider<TokenNotifier, String?>((ref) {
  final storage = FlutterSecureStorage();
  return TokenNotifier(storage);
});

final dioProvider = Provider<Dio>((ref) {
  var dio = Dio();  // Configure Dio instance with base options
  final token = ref.watch(tokenProvider);
  if (token != null) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
  return dio;
});
