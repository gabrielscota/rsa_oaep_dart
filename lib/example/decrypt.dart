import 'dart:convert';
import 'dart:io';

import 'package:pointycastle/export.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

void main() {
  // 1. Carregar chave privada
  final pem = File('private.pem').readAsStringSync();
  final privateKey = RSAKeyParser.parsePrivateKeyFromPem(pem);

  final publicKey = File('public.pem').readAsStringSync();
  final publicKeyParsed = RSAKeyParser.parsePublicKeyFromPem(publicKey);

  // 2. Criar RSAOAEP
  final oaep = RSAOAEP(
    hash: SHA256Digest(),
    publicKey: publicKeyParsed,
    privateKey: privateKey,
  );

  // 3. Ler ciphertext gerado pelo OpenSSL
  final ciphertext = File('ciphertext_openssl.bin').readAsBytesSync();
  print('Ciphertext lido de ciphertext_openssl.bin');
  print('Ciphertext: ${base64.encode(ciphertext)}');

  // 4. Descriptografar
  final plaintextBytes = oaep.decrypt(ciphertext);
  final plaintext = utf8.decode(plaintextBytes);

  print('Decrypted plaintext: $plaintext');
}
