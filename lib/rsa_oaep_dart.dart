/// A Dart library for RSA-OAEP encryption and decryption operations.
///
/// This library provides a pure Dart implementation of RSAES-OAEP
/// (RSA Encryption Scheme - Optimal Asymmetric Encryption Padding)
/// as defined in RFC 3447 (PKCS #1 v2.1).
///
/// ## Features
///
/// - RSA-OAEP encryption and decryption with customizable hash functions
/// - RSA key pair generation with configurable parameters
/// - PEM format key parsing for interoperability
/// - MGF1 mask generation function implementation
/// - Support for both binary data and string operations
///
/// ## Quick Start
///
/// ```dart
/// import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
///
/// // Generate a key pair
/// final keyPair = RSAKeyUtils.generateKeyPair(bitLength: 2048);
///
/// // Create OAEP cipher with SHA-256
/// final oaep = RSAOAEP(hash: SHA256Digest());
///
/// // Encrypt and decrypt a message
/// final message = 'Hello, World!';
/// final encrypted = oaep.encryptString(message, keyPair.publicKey);
/// final decrypted = oaep.decryptString(encrypted, keyPair.privateKey);
/// ```
///
/// ## Interoperability
///
/// This library is designed to be compatible with standard RSA-OAEP
/// implementations in other languages and tools (OpenSSL, Java, Python, etc.).
///
/// ## Security Notes
///
/// - Always use key sizes of at least 2048 bits for production use
/// - SHA-256 or higher hash functions are recommended
/// - This implementation includes protections against timing attacks
///
/// See the individual classes for detailed usage examples and API documentation.
library;

export 'package:pointycastle/export.dart' show SHA256Digest, AsymmetricKeyPair, RSAPublicKey, RSAPrivateKey;

export 'src/mgf1.dart';
export 'src/rsa_key_parser.dart';
export 'src/rsa_key_utils.dart';
export 'src/rsa_oaep.dart';
export 'src/utils.dart';
