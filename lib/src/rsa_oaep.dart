import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

import 'mgf1.dart';
import 'utils.dart';

/// Implementation of RSAES-OAEP (PKCS#1 v2.1+) encryption and decryption.
///
/// This class provides RSA-OAEP (Optimal Asymmetric Encryption Padding)
/// operations using a specified hash function. OAEP is a secure padding
/// scheme that provides semantic security for RSA encryption.
///
/// For interoperability with external systems, always convert your String
/// to bytes (UTF-8) before encrypting, and convert the decrypted result
/// from bytes to String using UTF-8.
///
/// Example usage:
/// ```dart
/// final oaep = RSAOAEP(hash: SHA256Digest());
/// final messageBytes = Uint8List.fromList(utf8.encode('Secret message'));
/// final cipher = oaep.encrypt(messageBytes, publicKey);
/// final plainBytes = oaep.decrypt(cipher, privateKey);
/// final plainText = utf8.decode(plainBytes);
/// ```
///
/// See also:
/// - RFC 3447 for the complete RSAES-OAEP specification
/// - [RSAKeyParser] for loading RSA keys from PEM format
/// - [RSAKeyUtils] for generating new RSA key pairs
class RSAOAEP {
  /// Creates an RSAOAEP instance for OAEP operations.
  ///
  /// The [hash] parameter defines the hash algorithm used for OAEP
  /// (e.g., SHA-256, SHA-512). The hash function affects both security
  /// and the maximum message length that can be encrypted.
  ///
  /// Example:
  /// ```dart
  /// final oaep = RSAOAEP(hash: SHA256Digest());
  /// ```
  RSAOAEP({required this.hash});

  /// The hash function used for OAEP operations.
  final Digest hash;

  /// Encrypts a message using RSA-OAEP with the provided public key.
  ///
  /// Parameters:
  /// - [message]: The message to be encrypted as bytes
  /// - [publicKey]: The RSA public key for encryption
  /// - [label]: Optional label for additional authentication (default: empty)
  ///
  /// Returns the ciphertext as [Uint8List].
  ///
  /// The maximum message length depends on the key size and hash function:
  /// `maxLength = keySize - 2 * hashLength - 2`
  ///
  /// For a 2048-bit key with SHA-256:
  /// `maxLength = 256 - 2 * 32 - 2 = 190 bytes`
  ///
  /// Throws [ArgumentError] if the message is too long for the key size.
  ///
  /// Example:
  /// ```dart
  /// final message = utf8.encode('Hello, World!');
  /// final encrypted = oaep.encrypt(Uint8List.fromList(message), publicKey);
  /// ```
  Uint8List encrypt(Uint8List message, RSAPublicKey publicKey, {Uint8List? label}) {
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

  /// Encrypts a string message and returns the ciphertext encoded in Base64.
  ///
  /// This is a convenience method that internally converts the string to
  /// bytes using UTF-8, encrypts it, and encodes the result in Base64.
  ///
  /// Parameters:
  /// - [message]: The string message to encrypt
  /// - [publicKey]: The RSA public key for encryption
  /// - [label]: Optional label for additional authentication
  ///
  /// Returns the encrypted data as a Base64-encoded string.
  ///
  /// Example:
  /// ```dart
  /// final encryptedBase64 = oaep.encryptString("Hello", publicKey);
  /// ```
  String encryptString(String message, RSAPublicKey publicKey, {Uint8List? label}) {
    final messageBytes = Uint8List.fromList(utf8.encode(message));
    final ciphertext = encrypt(messageBytes, publicKey, label: label);
    return base64.encode(ciphertext);
  }

  /// Decrypts ciphertext using RSA-OAEP with the provided private key.
  ///
  /// Parameters:
  /// - [ciphertext]: The encrypted data as bytes
  /// - [privateKey]: The RSA private key for decryption
  /// - [label]: Optional label that must match the one used during encryption
  ///
  /// Returns the decrypted message as [Uint8List].
  ///
  /// The decryption process verifies the OAEP padding and label hash.
  /// Any tampering with the ciphertext or incorrect keys will result in
  /// a decryption error.
  ///
  /// Throws [ArgumentError] if:
  /// - The ciphertext length doesn't match the key size
  /// - The padding is invalid
  /// - The label doesn't match
  /// - Any other decryption error occurs
  ///
  /// Example:
  /// ```dart
  /// final decrypted = oaep.decrypt(ciphertext, privateKey);
  /// final message = utf8.decode(decrypted);
  /// ```
  Uint8List decrypt(Uint8List ciphertext, RSAPrivateKey privateKey, {Uint8List? label}) {
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

  /// Decrypts a Base64-encoded ciphertext and returns the message as a string.
  ///
  /// This is a convenience method that internally decodes the Base64 to bytes,
  /// decrypts it, and converts the result to a string using UTF-8.
  ///
  /// Parameters:
  /// - [ciphertextBase64]: The Base64-encoded ciphertext
  /// - [privateKey]: The RSA private key for decryption
  /// - [label]: Optional label that must match the one used during encryption
  ///
  /// Returns the decrypted message as a string.
  ///
  /// Example:
  /// ```dart
  /// final decryptedMessage = oaep.decryptString(ciphertextBase64, privateKey);
  /// ```
  String decryptString(String ciphertextBase64, RSAPrivateKey privateKey, {Uint8List? label}) {
    final ciphertextBytes = base64.decode(ciphertextBase64);
    final plainBytes = decrypt(ciphertextBytes, privateKey, label: label);
    return utf8.decode(plainBytes);
  }

  /// Computes the hash digest of the given data.
  Uint8List _digest(Uint8List data) {
    hash.reset();
    return hash.process(data);
  }

  /// Generates cryptographically secure random bytes.
  Uint8List _randomBytes(int length) {
    final rnd = Random.secure();
    return Uint8List.fromList(List.generate(length, (_) => rnd.nextInt(256)));
  }

  /// Performs XOR operation between two byte arrays.
  Uint8List _xor(Uint8List a, Uint8List b) {
    return Uint8List.fromList(List.generate(a.length, (i) => a[i] ^ b[i]));
  }

  /// Compares two byte arrays in constant time to prevent timing attacks.
  bool _equal(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }
}
