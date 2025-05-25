import 'dart:convert';
import 'dart:io';

import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// ignore_for_file: avoid_print

/// Example demonstrating RSA-OAEP decryption of binary data using a private key.
///
/// This example reads encrypted binary data and a private key from files,
/// then decrypts the data using RSA-OAEP with SHA-256 hash function and
/// converts the result back to UTF-8 string.
///
/// Required files:
/// - `private.pem`: RSA private key in PEM format
/// - `ciphertext_openssl.bin`: Binary file containing raw encrypted bytes
///
/// The decryption workflow:
/// 1. Load the RSA private key from PEM file
/// 2. Initialize RSA-OAEP cipher with SHA-256 digest
/// 3. Read the raw encrypted binary data
/// 4. Decrypt the binary data to get plaintext bytes
/// 5. Convert decrypted bytes to UTF-8 string
///
/// This example works with raw binary data (as opposed to Base64 encoded data).
void main() {
  // Load RSA private key from PEM file
  final pem = File('private.pem').readAsStringSync();
  final privateKey = RSAKeyParser.parsePrivateKeyFromPem(pem);

  // Initialize RSA-OAEP cipher with SHA-256 hash function
  final oaep = RSAOAEP(hash: SHA256Digest());

  // Read raw encrypted binary data from file
  final ciphertext = File('ciphertext_openssl.bin').readAsBytesSync();
  print('Ciphertext lido de ciphertext_openssl.bin');
  print('Ciphertext: ${base64.encode(ciphertext)}');

  // Decrypt the binary data to get plaintext bytes
  final plaintextBytes = oaep.decrypt(ciphertext, privateKey);

  // Convert decrypted bytes to UTF-8 string
  final plaintext = utf8.decode(plaintextBytes);

  print('Decrypted plaintext: $plaintext');
}
