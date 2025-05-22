import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
import 'package:test/test.dart';

void main() {
  test('RSAES-OAEP Encryption and Decryption', () {
    final keyParams = RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 5);
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seeds = List<int>.generate(32, (_) => random.nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    final rngParams = ParametersWithRandom(keyParams, secureRandom);
    final generator = RSAKeyGenerator()..init(rngParams);
    final pair = generator.generateKeyPair();

    final publicKey = pair.publicKey;
    final privateKey = pair.privateKey;

    final oaep = RSAOAEP(hash: SHA256Digest());

    final message = utf8.encode('Hello, Gabriel!');
    final ciphertext = oaep.encrypt(message, publicKey);
    final decrypted = oaep.decrypt(ciphertext, privateKey);

    expect(decrypted, equals(message));
  });

  test('RSAES-OAEP Encryption with oversized message should throw', () {
    final keyParams = RSAKeyGeneratorParameters(BigInt.parse('65537'), 1024, 5);
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seeds = List<int>.generate(32, (_) => random.nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    final rngParams = ParametersWithRandom(keyParams, secureRandom);
    final generator = RSAKeyGenerator()..init(rngParams);
    final pair = generator.generateKeyPair();

    final publicKey = pair.publicKey;
    final oaep = RSAOAEP(hash: SHA256Digest());

    final k = (publicKey.modulus!.bitLength + 7) ~/ 8;
    final hLen = SHA256Digest().digestSize;
    final maxMessageLength = k - 2 * hLen - 2;

    final oversizedMessage = Uint8List(maxMessageLength + 1);

    expect(() => oaep.encrypt(oversizedMessage, publicKey), throwsArgumentError);
  });

  test('RSAES-OAEP Decryption with wrong ciphertext length should throw', () {
    final keyParams = RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 5);
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seeds = List<int>.generate(32, (_) => random.nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    final rngParams = ParametersWithRandom(keyParams, secureRandom);
    final generator = RSAKeyGenerator()..init(rngParams);
    final pair = generator.generateKeyPair();

    final privateKey = pair.privateKey;

    final oaep = RSAOAEP(hash: SHA256Digest());

    final invalidCiphertext = Uint8List(10);

    expect(() => oaep.decrypt(invalidCiphertext, privateKey), throwsArgumentError);
  });
}
