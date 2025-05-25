import 'dart:convert';
import 'dart:io';

import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// ignore_for_file: avoid_print

/// Example demonstrating how to decrypt RSA-OAEP encrypted data using a private key.
///
/// This example reads an encrypted binary file and a private key from PEM format,
/// then decrypts the data using RSA-OAEP with SHA-256 hash function.
///
/// Required files:
/// - `private.pem`: RSA private key in PEM format
/// - `ciphertext_for_openssl.bin`: Binary file containing encrypted data
///
/// The decryption process:
/// 1. Load the private key from PEM file
/// 2. Initialize RSA-OAEP with SHA-256 digest
/// 3. Read the encrypted binary data
/// 4. Convert binary data to Base64 for display
/// 5. Decrypt the data and display the plaintext
void main() {
  // Load RSA private key from PEM file
  final pem = File('private.pem').readAsStringSync();
  final privateKey = RSAKeyParser.parsePrivateKeyFromPem(pem);

  // Initialize RSA-OAEP cipher with SHA-256 hash function
  final oaep = RSAOAEP(hash: SHA256Digest());

  // Read encrypted binary data from file
  final binaryData = File('ciphertext_for_openssl.bin').readAsBytesSync();

  // Convert to Base64 for display purposes
  final ciphertextBase64 = base64.encode(binaryData);
  print('Ciphertext binário lido de ciphertext_for_openssl.bin');
  print('Ciphertext (Base64): $ciphertextBase64');

  // Decrypt the ciphertext using RSA-OAEP
  final plaintext = oaep.decryptString(ciphertextBase64, privateKey);

  print('Decrypted plaintext: $plaintext');
}
