import 'dart:convert';
import 'dart:typed_data';

import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
import 'package:test/test.dart';

void main() {
  test('RSAES-OAEP Encryption and Decryption', () {
    final pair = RSAKeyUtils.generateKeyPair(bitLength: 2048);

    final publicKey = pair.publicKey;
    final privateKey = pair.privateKey;

    final oaep = RSAOAEP(hash: SHA256Digest());

    final message = utf8.encode('Hello, Gabriel!');
    final ciphertext = oaep.encrypt(message, publicKey);
    final decrypted = oaep.decrypt(ciphertext, privateKey);

    expect(decrypted, equals(message));
  });

  test('RSAES-OAEP Encryption with oversized message should throw', () {
    final pair = RSAKeyUtils.generateKeyPair(bitLength: 1024);

    final publicKey = pair.publicKey;
    final oaep = RSAOAEP(hash: SHA256Digest());

    final k = (publicKey.modulus!.bitLength + 7) ~/ 8;
    final hLen = SHA256Digest().digestSize;
    final maxMessageLength = k - 2 * hLen - 2;

    final oversizedMessage = Uint8List(maxMessageLength + 1);

    expect(() => oaep.encrypt(oversizedMessage, publicKey), throwsArgumentError);
  });

  test('RSAES-OAEP Decryption with wrong ciphertext length should throw', () {
    final pair = RSAKeyUtils.generateKeyPair(bitLength: 2048);

    final privateKey = pair.privateKey;

    final oaep = RSAOAEP(hash: SHA256Digest());

    final invalidCiphertext = Uint8List(10);

    expect(() => oaep.decrypt(invalidCiphertext, privateKey), throwsArgumentError);
  });
}
