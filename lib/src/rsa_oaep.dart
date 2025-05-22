import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

import 'mgf1.dart';
import 'utils.dart';

/// Classe para operações RSAES-OAEP (PKCS#1 v2.1+).
///
/// Observação: Para interoperar com sistemas externos, sempre converta sua String para bytes (UTF-8) antes de criptografar,
/// e converta o resultado descriptografado de bytes para String usando UTF-8.
///
/// Exemplo de uso:
/// ```dart
/// final oaep = RSAOAEP(hash: SHA256Digest());
/// final messageBytes = Uint8List.fromList(utf8.encode('Mensagem secreta'));
/// final cipher = oaep.encrypt(messageBytes, publicKey);
/// final plainBytes = oaep.decrypt(cipher, privateKey);
/// final plainText = utf8.decode(plainBytes);
/// ```
class RSAOAEP {
  /// Cria uma instância de RSAOAEP para operações OAEP.
  /// O [hash] define o algoritmo de hash usado para OAEP (ex: SHA-256).
  RSAOAEP({required this.hash});

  final Digest hash;

  /// Criptografa uma [message] (Uint8List) usando a [publicKey] (RSAPublicKey) e, opcionalmente, um [label] (Uint8List?).
  ///
  /// - [message]: mensagem a ser criptografada (Uint8List).
  /// - [publicKey]: chave pública RSA (RSAPublicKey).
  /// - [label]: rótulo opcional (Uint8List?), padrão é vazio.
  ///
  /// Retorna o ciphertext como Uint8List.
  ///
  /// Lança [ArgumentError] se a mensagem for muito longa para o tamanho da chave.
  Uint8List encrypt(
    Uint8List message,
    RSAPublicKey publicKey, {
    Uint8List? label,
  }) {
    final k = (publicKey.modulus!.bitLength + 7) ~/ 8;
    final hLen = hash.digestSize;
    final effectiveLabel = label ?? Uint8List(0);

    if (message.length > k - 2 * hLen - 2) {
      throw ArgumentError('Message too long');
    }

    final lHash = _digest(effectiveLabel);
    final ps = Uint8List(k - message.length - 2 * hLen - 2);
    final db = Uint8List.fromList([...lHash, ...ps, 0x01, ...message]);

    final seed = _randomBytes(hLen);
    final dbMask = mgf1(seed, k - hLen - 1, hash);
    final maskedDB = _xor(db, dbMask);

    final seedMask = mgf1(maskedDB, hLen, hash);
    final maskedSeed = _xor(seed, seedMask);

    final em = Uint8List.fromList([0x00, ...maskedSeed, ...maskedDB]);

    final m = os2ip(em);
    final c = m.modPow(publicKey.exponent!, publicKey.modulus!);
    return i2osp(c, k);
  }

  /// Descriptografa um [ciphertext] (Uint8List) usando a [privateKey] (RSAPrivateKey) e, opcionalmente, um [label] (Uint8List?).
  ///
  /// - [ciphertext]: dados criptografados (Uint8List).
  /// - [privateKey]: chave privada RSA (RSAPrivateKey).
  /// - [label]: rótulo opcional (Uint8List?), padrão é vazio.
  ///
  /// Retorna a mensagem descriptografada como Uint8List.
  ///
  /// Lança [ArgumentError] se os dados estiverem inválidos ou a descriptografia falhar.
  Uint8List decrypt(
    Uint8List ciphertext,
    RSAPrivateKey privateKey, {
    Uint8List? label,
  }) {
    final k = (privateKey.modulus!.bitLength + 7) ~/ 8;
    final hLen = hash.digestSize;
    final effectiveLabel = label ?? Uint8List(0);

    if (ciphertext.length != k) {
      throw ArgumentError('Decryption error');
    }

    final c = os2ip(ciphertext);
    final m = c.modPow(privateKey.exponent!, privateKey.modulus!);
    final em = i2osp(m, k);

    if (em[0] != 0x00) {
      throw ArgumentError('Decryption error');
    }

    final maskedSeed = em.sublist(1, hLen + 1);
    final maskedDB = em.sublist(hLen + 1);

    final seedMask = mgf1(maskedDB, hLen, hash);
    final seed = _xor(maskedSeed, seedMask);

    final dbMask = mgf1(seed, k - hLen - 1, hash);
    final db = _xor(maskedDB, dbMask);

    final lHash = _digest(effectiveLabel);
    final lHashPrime = db.sublist(0, hLen);

    if (!_equal(lHash, lHashPrime)) {
      throw ArgumentError('Decryption error');
    }

    int index = hLen;
    while (index < db.length && db[index] == 0x00) {
      index++;
    }

    if (index == db.length || db[index] != 0x01) {
      throw ArgumentError('Decryption error');
    }

    return db.sublist(index + 1);
  }

  Uint8List _digest(Uint8List data) {
    hash.reset();
    return hash.process(data);
  }

  Uint8List _randomBytes(int length) {
    final rnd = Random.secure();
    return Uint8List.fromList(List.generate(length, (_) => rnd.nextInt(256)));
  }

  Uint8List _xor(Uint8List a, Uint8List b) {
    return Uint8List.fromList(List.generate(a.length, (i) => a[i] ^ b[i]));
  }

  bool _equal(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }

  /// Gera um par de chaves RSA (pública e privada).
  ///
  /// [bitLength] define o tamanho das chaves em bits (ex: 2048, 3072, 4096).
  ///
  /// Retorna uma instância de [AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>].
  ///
  /// Exemplo de uso:
  /// ```dart
  /// final keyPair = RSAOAEP.generateKeyPair(bitLength: 2048);
  /// final publicKey = keyPair.publicKey;
  /// final privateKey = keyPair.privateKey;
  /// ```
  static AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateKeyPair({int bitLength = 2048}) {
    final keyParams = RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64);
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seeds = List<int>.generate(32, (_) => random.nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    final generator = RSAKeyGenerator()..init(ParametersWithRandom(keyParams, secureRandom));

    final pair = generator.generateKeyPair();
    return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(pair.publicKey, pair.privateKey);
  }
}
