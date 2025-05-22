import 'dart:convert';
import 'dart:io';

import 'package:pointycastle/export.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

void main() {
  // 1. Carregar a chave pública
  final pem = File('public.pem').readAsStringSync();
  final publicKey = RSAKeyParser.parsePublicKeyFromPem(pem);

  // 2. Criar instância do RSAOAEP com SHA-256
  final oaep = RSAOAEP(hash: SHA256Digest(), publicKey: publicKey);

  // 3. Mensagem para criptografar
  final message = utf8.encode('Hello, Gabriel!');

  // 4. Criptografar
  final ciphertext = oaep.encrypt(message);
  print('Ciphertext: ${base64.encode(ciphertext)}');

  // 5. Salvar ciphertext em arquivo binário
  final file = File('ciphertext.bin');
  file.writeAsBytesSync(ciphertext);

  print('Ciphertext salvo em ciphertext.bin');
}
