# RSA OAEP Dart Library

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Pub Version](https://img.shields.io/pub/v/rsa_oaep_dart.svg)](https://pub.dev/packages/rsa_oaep_dart)
[![Test](https://github.com/gabrielscota/rsa_oaep_dart/actions/workflows/test.yml/badge.svg)](https://github.com/gabrielscota/rsa_oaep_dart/actions/workflows/test.yml)
[![Dart SDK](https://img.shields.io/badge/Dart-%3E%3D3.0.0-blue)](https://dart.dev)
[![codecov](https://codecov.io/gh/gabrielscota/rsa_oaep_dart/branch/main/graph/badge.svg)](https://codecov.io/gh/gabrielscota/rsa_oaep_dart)

Pure Dart implementation of **RSAES-OAEP** (PKCS#1 v2.2) with **SHA-256** support.  
Ideal for projects that need secure asymmetric encryption without native dependencies.

> Works on Flutter, web, and backend — anywhere Dart runs.

## Compatibility

This library supports **Dart SDK 3.0.0 or newer** and **Flutter 3.10+**.

- Dart: >=3.0.0 <4.0.0
- Flutter: >=3.10.0

## Features

- RSAES-OAEP with MGF1 as specified in RFC 8017
- SHA-256 hash (recommended default)
- Full interoperability with OpenSSL and other toolchains
- Secure RSA key generation (2048, 3072, 4096 bits)
- PEM key parsing for import/export
- Simple API for strings and binary data
- Pure Dart code — great for Flutter, web, and server
- Extensive tests and practical examples

## Getting started

### Install

Add to your `pubspec.yaml`:

```yaml
dependencies:
  rsa_oaep_dart: ^0.1.6
```

Then run:

```bash
dart pub get
```

### Import

```dart
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
```

### Docs

Read the full API docs on [pub.dev](https://pub.dev/documentation/rsa_oaep_dart/latest/).

## Examples

### Basic usage

```dart
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// Generate a key pair
final keyPair = RSAKeyUtils.generateKeyPair(bitLength: 2048);

// Create OAEP instance with SHA-256
final oaep = RSAOAEP(hash: SHA256Digest());

// Encrypt message
final message = 'Hello, world!';
final encrypted = oaep.encryptString(message, keyPair.publicKey);

// Decrypt message
final decrypted = oaep.decryptString(encrypted, keyPair.privateKey);
print(decrypted); // Output: Hello, world!
```

### Run the full example suite

```bash
cd example
make
```

The interactive menu includes:

- RSA key generation
- Encrypt with Dart and OpenSSL
- Decrypt with Dart and OpenSSL
- Interoperability workflows

## Testing

```bash
dart test
```

## Compliance

- RFC 8017 — PKCS#1 v2.2
- MGF1 with SHA-256
- Compatible with `openssl pkeyutl`

## Security notes

This library follows best practices for cryptographic operations:

- Secure key generation
- Correct OAEP + MGF1 usage
- Proper invalid-message handling

## Interoperability and best practices

### Message conversion

To interoperate with external systems (AWS KMS, OpenSSL, Java, Python, etc.):

```dart
// Always convert strings to UTF-8 bytes before encrypting
final messageBytes = Uint8List.fromList(utf8.encode('Your message'));
final encrypted = oaep.encrypt(messageBytes, publicKey);
```

```dart
// Decrypt returns bytes — convert to String if needed
final decryptedBytes = oaep.decrypt(ciphertext, privateKey);
final message = utf8.decode(decryptedBytes);
```

### Transport and storage

Use Base64 for transport or storage:

```dart
final ciphertextBase64 = base64.encode(ciphertext);
final ciphertext = base64.decode(ciphertextBase64);
```

### Convenience methods

```dart
// Encrypt a String (returns Base64)
final encryptedBase64 = oaep.encryptString('Message', publicKey);

// Decrypt Base64 (returns String)
final decrypted = oaep.decryptString(encryptedBase64, privateKey);
```

### Message size limits

RSA-OAEP has maximum input sizes:

- 2048-bit key + SHA-256: 190 bytes
- 3072-bit key + SHA-256: 318 bytes
- 4096-bit key + SHA-256: 446 bytes

For larger payloads, use hybrid crypto (RSA + AES).

## Roadmap

- [ ] SHA-1 and SHA-512 support
- [ ] Custom OAEP labels
- [ ] Performance benchmarks
- [ ] Flutter UI example app
- [ ] Security audit

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md).

### How to contribute

1. Fork the repo
2. Create a branch: `git checkout -b feature/your-change`
3. Commit: `git commit -m 'feat: add your change'`
4. Push: `git push origin feature/your-change`
5. Open a Pull Request

## License

MIT — see [LICENSE](LICENSE).
