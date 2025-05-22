import 'dart:convert';
import 'dart:io';

import 'package:pointycastle/export.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// ignore_for_file: avoid_print

void main() {
  final pem = File('private.pem').readAsStringSync();
  final privateKey = RSAKeyParser.parsePrivateKeyFromPem(pem);

  final publicKey = File('public.pem').readAsStringSync();
  final publicKeyParsed = RSAKeyParser.parsePublicKeyFromPem(publicKey);

  final oaep = RSAOAEP(hash: SHA256Digest(), publicKey: publicKeyParsed, privateKey: privateKey);

  final ciphertext = File('ciphertext_openssl.bin').readAsBytesSync();
  print('Ciphertext lido de ciphertext_openssl.bin');
  print('Ciphertext: ${base64.encode(ciphertext)}');

  final plaintextBytes = oaep.decrypt(ciphertext);
  final plaintext = utf8.decode(plaintextBytes);

  print('Decrypted plaintext: $plaintext');
}
