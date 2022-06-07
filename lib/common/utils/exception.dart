/// Exception class that will be thrown when there is a problem
/// related to the server.
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

/// Exception class that will be thrown when there is a problem
/// related to the firestore.
class FirestoreException implements Exception {
  final String message;

  FirestoreException(this.message);
}
