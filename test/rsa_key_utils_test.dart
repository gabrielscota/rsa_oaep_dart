import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
import 'package:test/test.dart';

void main() {
  group('RSAKeyUtils.generateKeyPair', () {
    test('Generates a key pair with default parameters (2048 bits, 65537 exponent, certainty 64)', () {
      final pair = RSAKeyUtils.generateKeyPair();
      expect(pair.publicKey, isA<RSAPublicKey>());
      expect(pair.privateKey, isA<RSAPrivateKey>());
      expect(pair.publicKey.modulus!.bitLength, greaterThanOrEqualTo(2048));
      expect(pair.publicKey.exponent, BigInt.from(65537));
    });

    test('Generates a key pair with custom parameters (3072 bits, exponent 3, certainty 16)', () {
      final customExponent = BigInt.from(3);
      final pair = RSAKeyUtils.generateKeyPair(
        publicExponent: customExponent,
        bitLength: 3072,
        certainty: 16,
      );
      expect(pair.publicKey.exponent, customExponent);
      expect(pair.publicKey.modulus!.bitLength, greaterThanOrEqualTo(3072));
    });

    test('Uses default exponent when publicExponent is null', () {
      final pair = RSAKeyUtils.generateKeyPair(publicExponent: null);
      expect(pair.publicKey.exponent, BigInt.from(65537));
    });
  });
}
