import 'dart:convert';
import 'dart:io';

import 'package:pointycastle/export.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// ignore_for_file: avoid_print

void main() {
  final pem = File('public.pem').readAsStringSync();
  final publicKey = RSAKeyParser.parsePublicKeyFromPem(pem);

  final oaep = RSAOAEP(hash: SHA256Digest());

  final message = utf8.encode('Hello, Gabriel!');

  final ciphertext = oaep.encrypt(message, publicKey);
  print('Ciphertext: ${base64.encode(ciphertext)}');

  final file = File('ciphertext.bin');
  file.writeAsBytesSync(ciphertext);

  print('Ciphertext salvo em ciphertext.bin');
}
