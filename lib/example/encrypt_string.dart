import 'dart:convert';
import 'dart:io';

import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// ignore_for_file: avoid_print

void main() {
  final pem = File('public.pem').readAsStringSync();
  final publicKey = RSAKeyParser.parsePublicKeyFromPem(pem);

  final oaep = RSAOAEP(hash: SHA256Digest());

  final message = 'Hello, Gabriel!';

  final ciphertextBase64 = oaep.encryptString(message, publicKey);
  print('Ciphertext (Base64): $ciphertextBase64');

  final ciphertextBytes = base64.decode(ciphertextBase64);
  final binaryFile = File('ciphertext_for_openssl.bin');
  binaryFile.writeAsBytesSync(ciphertextBytes);
  print('Ciphertext binário salvo em ciphertext_for_openssl.bin');
}
