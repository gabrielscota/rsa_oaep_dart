import 'dart:convert';
import 'dart:io';

import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// ignore_for_file: avoid_print

/// Example demonstrating RSA-OAEP encryption of string data using a public key.
///
/// This example loads a public key from a PEM file, encrypts a string message
/// using RSA-OAEP with SHA-256 hash function, and saves the encrypted data
/// as both Base64 string and binary file.
///
/// Required files:
/// - `public.pem`: RSA public key in PEM format
///
/// Generated files:
/// - `ciphertext_for_openssl.bin`: Binary file containing encrypted data
///
/// The encryption workflow:
/// 1. Load the RSA public key from PEM file
/// 2. Initialize RSA-OAEP cipher with SHA-256 digest
/// 3. Encrypt the string message to Base64 format
/// 4. Convert Base64 to binary data
/// 5. Save encrypted binary data to file for external tools compatibility
///
/// This example demonstrates string-to-Base64 encryption and binary file output.
void main() {
  // Load RSA public key from PEM file
  final pem = File('public.pem').readAsStringSync();
  final publicKey = RSAKeyParser.parsePublicKeyFromPem(pem);

  // Initialize RSA-OAEP cipher with SHA-256 hash function
  final oaep = RSAOAEP(hash: SHA256Digest());

  // Message to be encrypted
  final message = 'Hello, Gabriel!';

  // Encrypt the message to Base64 format
  final ciphertextBase64 = oaep.encryptString(message, publicKey);
  print('Ciphertext (Base64): $ciphertextBase64');

  // Convert Base64 to binary data and save to file
  final ciphertextBytes = base64.decode(ciphertextBase64);
  final binaryFile = File('ciphertext_for_openssl.bin');
  binaryFile.writeAsBytesSync(ciphertextBytes);
  print('Ciphertext binário salvo em ciphertext_for_openssl.bin');
}
