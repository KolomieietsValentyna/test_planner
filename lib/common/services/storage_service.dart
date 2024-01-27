import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create storage for interact with inner memory
  final _storage = const FlutterSecureStorage();

  // Get previous saved value by key
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // Delete previous saved value by key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Write or rewrite value by key
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}
