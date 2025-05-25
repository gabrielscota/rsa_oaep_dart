import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Utilities for RSA key generation and manipulation.
///
/// This class provides static methods for generating cryptographically secure
/// RSA key pairs using the PointyCastle cryptographic library.
///
/// The generated keys can be used for RSA-OAEP encryption/decryption operations
/// and other RSA-based cryptographic functions.
class RSAKeyUtils {
  /// Generates an RSA key pair (public and private keys).
  ///
  /// Creates a cryptographically secure RSA key pair using the specified
  /// parameters. The keys are generated using a secure random number generator
  /// seeded with cryptographically secure random data.
  ///
  /// Named parameters:
  /// - [publicExponent]: The public exponent (default: 65537, recommended value)
  /// - [bitLength]: The key size in bits (e.g., 2048, 3072, 4096, default: 2048)
  /// - [certainty]: The certainty level for primality testing (default: 64)
  ///
  /// Returns an [AsymmetricKeyPair] containing both public and private RSA keys.
  ///
  /// The [bitLength] should be at least 2048 bits for security. Common values are:
  /// - 2048 bits: Good security, faster operations
  /// - 3072 bits: Higher security, moderate performance
  /// - 4096 bits: Very high security, slower operations
  ///
  /// The [certainty] parameter controls the probability that generated primes
  /// are actually prime. Higher values increase security but slow generation.
  ///
  /// Example:
  /// ```dart
  /// // Generate 2048-bit key pair with default settings
  /// final keyPair = RSAKeyUtils.generateKeyPair();
  ///
  /// // Generate 4096-bit key pair with custom exponent
  /// final keyPair = RSAKeyUtils.generateKeyPair(
  ///   bitLength: 4096,
  ///   publicExponent: BigInt.from(65537)
  /// );
  ///
  /// final publicKey = keyPair.publicKey;
  /// final privateKey = keyPair.privateKey;
  /// ```
  ///
  /// See also:
  /// - [RSAKeyParser] for parsing existing PEM-formatted keys
  /// - [RSAOAEP] for using the generated keys in encryption operations
  static AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateKeyPair({
    BigInt? publicExponent,
    int bitLength = 2048,
    int certainty = 64,
  }) {
    final effectivePublicExponent = publicExponent ?? BigInt.from(65537);
    final keyParams = RSAKeyGeneratorParameters(effectivePublicExponent, bitLength, certainty);
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seeds = List<int>.generate(32, (_) => random.nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    final generator = RSAKeyGenerator()..init(ParametersWithRandom(keyParams, secureRandom));

    final pair = generator.generateKeyPair();
    return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(pair.publicKey, pair.privateKey);
  }
}
