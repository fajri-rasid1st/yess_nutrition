import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:yess_nutrition/common/utils/constants.dart';

class HttpSslPinning {
  static http.Client? _clientInstance;

  static http.Client get client {
    return _clientInstance ?? http.Client();
  }

  static Future<http.Client> get _instance async {
    return _clientInstance ??= await createLEClient();
  }

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<http.Client> createLEClient() async {
    final securityContext = SecurityContext();

    try {
      // certificate for News API
      final sslCert1 = await rootBundle.load(certificates['newsApi']!);

      securityContext.setTrustedCertificatesBytes(sslCert1.buffer.asInt8List());

      // certificate for Food, Product, and Recipe API
      final sslCert2 = await rootBundle.load(certificates['nutritionApi']!);

      securityContext.setTrustedCertificatesBytes(sslCert2.buffer.asInt8List());
    } on TlsException catch (e) {
      log('Error: ${e.message}');

      rethrow;
    } catch (e) {
      log('Unexpected error: $e');

      rethrow;
    }

    final client = HttpClient(context: securityContext);

    client.badCertificateCallback = rejectBadCertificate;

    final ioClient = IOClient(client);

    return ioClient;
  }

  static bool rejectBadCertificate(
    X509Certificate cert,
    String host,
    int port,
  ) {
    return false;
  }
}
