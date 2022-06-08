import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utilities {
  /// Function to create snack bar
  static SnackBar createSnackBar(String message) {
    return SnackBar(
      content: Text(message, style: GoogleFonts.plusJakartaSans()),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
    );
  }

  /// Function to encrypt text
  static String encryptText(String text) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(8);

    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));
    final encrypted = encrypter.encrypt(text, iv: iv);

    return encrypted.base64;
  }
}
