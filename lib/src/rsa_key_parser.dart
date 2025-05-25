import 'package:basic_utils/basic_utils.dart';

/// Utility class for parsing RSA keys from PEM format.
///
/// This class provides static methods to convert PEM strings into [RSAPublicKey]
/// and [RSAPrivateKey] objects that can be used for cryptographic operations.
///
/// The class acts as a convenient wrapper around the `basic_utils` package's
/// cryptographic utilities, providing a clean API for RSA key parsing.
///
/// Example:
/// ```dart
/// // Parse public key
/// final publicPem = '-----BEGIN PUBLIC KEY-----\n...';
/// final publicKey = RSAKeyParser.parsePublicKeyFromPem(publicPem);
///
/// // Parse private key
/// final privatePem = '-----BEGIN PRIVATE KEY-----\n...';
/// final privateKey = RSAKeyParser.parsePrivateKeyFromPem(privatePem);
/// ```
class RSAKeyParser {
  /// Parses an RSA public key from PEM format string.
  ///
  /// Converts a PEM-encoded public key string into an [RSAPublicKey] object
  /// that can be used for encryption and signature verification operations.
  ///
  /// The [pemString] should contain a valid PEM-formatted public key with
  /// proper BEGIN/END PUBLIC KEY markers.
  ///
  /// Returns an [RSAPublicKey] instance ready for cryptographic operations.
  ///
  /// Throws [FormatException] if the PEM string is malformed or invalid.
  ///
  /// Example:
  /// ```dart
  /// final pem = File('public.pem').readAsStringSync();
  /// final publicKey = RSAKeyParser.parsePublicKeyFromPem(pem);
  /// ```
  static RSAPublicKey parsePublicKeyFromPem(String pemString) {
    return CryptoUtils.rsaPublicKeyFromPem(pemString);
  }

  /// Parses an RSA private key from PEM format string.
  ///
  /// Converts a PEM-encoded private key string into an [RSAPrivateKey] object
  /// that can be used for decryption and signature generation operations.
  ///
  /// The [pemString] should contain a valid PEM-formatted private key with
  /// proper BEGIN/END PRIVATE KEY or BEGIN/END RSA PRIVATE KEY markers.
  ///
  /// Returns an [RSAPrivateKey] instance ready for cryptographic operations.
  ///
  /// Throws [FormatException] if the PEM string is malformed or invalid.
  ///
  /// Example:
  /// ```dart
  /// final pem = File('private.pem').readAsStringSync();
  /// final privateKey = RSAKeyParser.parsePrivateKeyFromPem(pem);
  /// ```
  static RSAPrivateKey parsePrivateKeyFromPem(String pemString) {
    return CryptoUtils.rsaPrivateKeyFromPem(pemString);
  }
}
