import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'Database.dart' as d;

class DatabaseSembastProvider implements d.Database<Map<String, dynamic>> {
  String dbPath = 'sample.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  final String collectionName;

  DatabaseSembastProvider({required this.collectionName}) : super();

  @override
  Future<List<Map<String, dynamic>>?> readAllFromDB() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> readFromDB(key) {
    // TODO: implement readFromDB
    throw UnimplementedError();
  }

  @override
  Future<void> updateDB(key, Map<String, dynamic> data) {
    // TODO: implement updateDB
    throw UnimplementedError();
  }

  @override
  Future<void> writeToDB(key, Map<String, dynamic> data) {
    // TODO: implement writeToDB
    throw UnimplementedError();
  }
}
