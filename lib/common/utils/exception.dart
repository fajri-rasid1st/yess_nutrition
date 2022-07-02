/// Exception class that will be thrown when there is a problem
/// related to the firestore.
class FirestoreException implements Exception {
  final String message;

  FirestoreException(this.message);
}

/// Exception class that will be thrown when there is a problem
/// related to the firebase storage.
class StorageException implements Exception {
  final String message;

  StorageException(this.message);
}

/// Exception class that will be thrown when there is a problem
/// related to the database.
class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

/// Exception class that will be thrown when there is a problem
/// related to the server.
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}
