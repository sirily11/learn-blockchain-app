abstract class Database<T> {
  Future<void> writeToDB(key, T data);

  Future<T?> readFromDB(dynamic key);

  Future<List<T>?> readAllFromDB();

  Future<void> updateDB(dynamic key, T data);
}
