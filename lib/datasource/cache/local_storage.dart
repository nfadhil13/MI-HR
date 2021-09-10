import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  final _secureStorage = FlutterSecureStorage();

  factory LocalStorage() {
    return _instance;
  }

  FlutterSecureStorage get secureStorage {
    return _secureStorage;
  }

  LocalStorage._internal();

}