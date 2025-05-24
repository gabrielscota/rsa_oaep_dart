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

  group('RSAOAEP String methods', () {
    final pair = RSAKeyUtils.generateKeyPair(bitLength: 2048);
    final oaep = RSAOAEP(hash: SHA256Digest());

    test('encryptString and decryptString should return original message', () {
      final message = 'Test message for RSA OAEP';
      final encryptedBase64 = oaep.encryptString(message, pair.publicKey);
      final decryptedMessage = oaep.decryptString(encryptedBase64, pair.privateKey);

      expect(decryptedMessage, equals(message));
    });

    test('encryptString should produce a non-empty base64 string', () {
      final message = 'Another test';
      final encryptedBase64 = oaep.encryptString(message, pair.publicKey);

      expect(encryptedBase64, isNotEmpty);
      expect(base64.decode(encryptedBase64), isA<List<int>>());
    });
  });
}
