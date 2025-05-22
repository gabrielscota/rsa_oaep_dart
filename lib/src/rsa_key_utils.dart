import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Utilitários para geração e manipulação de chaves RSA.
class RSAKeyUtils {
  /// Gera um par de chaves RSA (pública e privada).
  ///
  /// Parâmetros nomeados:
  /// - [publicExponent]: expoente público (padrão: 65537).
  /// - [bitLength]: tamanho das chaves em bits (ex: 2048, 3072, 4096, padrão: 2048).
  /// - [certainty]: nível de certeza para teste de primalidade dos primos (padrão: 64).
  ///
  /// Retorna uma instância de [AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>].
  ///
  /// Exemplo de uso:
  /// ```dart
  /// final keyPair = RSAKeyUtils.generateKeyPair(bitLength: 2048, publicExponent: BigInt.parse('65537'));
  /// final publicKey = keyPair.publicKey;
  /// final privateKey = keyPair.privateKey;
  /// ```
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
