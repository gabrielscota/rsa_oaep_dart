import 'dart:convert';
import 'dart:io';

import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// ignore_for_file: avoid_print

/// Example demonstrating RSA-OAEP encryption of binary data using a public key.
///
/// This example loads a public key from a PEM file, converts a string message
/// to UTF-8 bytes, encrypts the binary data using RSA-OAEP with SHA-256 hash
/// function, and saves the raw encrypted bytes to a binary file.
///
/// Required files:
/// - `public.pem`: RSA public key in PEM format
///
/// Generated files:
/// - `ciphertext.bin`: Binary file containing raw encrypted bytes
///
/// The encryption workflow:
/// 1. Load the RSA public key from PEM file
/// 2. Initialize RSA-OAEP cipher with SHA-256 digest
/// 3. Convert string message to UTF-8 bytes
/// 4. Encrypt the binary data directly
/// 5. Save raw encrypted bytes to binary file
///
/// This example works with raw binary data (as opposed to Base64 encoded output).
void main() {
  // Load RSA public key from PEM file
  final pem = File('public.pem').readAsStringSync();
  final publicKey = RSAKeyParser.parsePublicKeyFromPem(pem);

  // Initialize RSA-OAEP cipher with SHA-256 hash function
  final oaep = RSAOAEP(hash: SHA256Digest());

  // Convert string message to UTF-8 bytes for encryption
  final message = utf8.encode('Hello, Gabriel!');

  // Encrypt the binary data directly
  final ciphertext = oaep.encrypt(message, publicKey);
  print('Ciphertext: ${base64.encode(ciphertext)}');

  // Save raw encrypted bytes to binary file
  final file = File('ciphertext.bin');
  file.writeAsBytesSync(ciphertext);

  print('Ciphertext salvo em ciphertext.bin');
}
