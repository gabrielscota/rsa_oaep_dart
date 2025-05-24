import 'dart:convert';
import 'dart:io';

import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// ignore_for_file: avoid_print

void main() {
  final pem = File('private.pem').readAsStringSync();
  final privateKey = RSAKeyParser.parsePrivateKeyFromPem(pem);

  final oaep = RSAOAEP(hash: SHA256Digest());

  final binaryData = File('ciphertext_for_openssl.bin').readAsBytesSync();
  final ciphertextBase64 = base64.encode(binaryData);
  print('Ciphertext binário lido de ciphertext_for_openssl.bin');
  print('Ciphertext (Base64): $ciphertextBase64');

  final plaintext = oaep.decryptString(ciphertextBase64, privateKey);

  print('Decrypted plaintext: $plaintext');
}
