# RSA-OAEP Dart Examples

This directory contains practical examples demonstrating how to use the `rsa_oaep_dart` library for RSA-OAEP encryption and decryption operations.

## Prerequisites

Before running these examples, you need RSA key files in PEM format. You can generate them using the provided Makefile:

```bash
# Generate RSA key pair using the Makefile
make keys
```

Or manually with OpenSSL:

```bash
# Generate a 2048-bit RSA private key
openssl genpkey -algorithm RSA -out private.pem -pkeyopt rsa_keygen_bits:2048

# Extract the public key from the private key
openssl rsa -pubout -in private.pem -out public.pem
```

## Examples Overview

### 1. String Encryption (`encrypt_string.dart`)

Demonstrates encrypting a string message and saving the encrypted data as a binary file compatible with external tools like OpenSSL.

**Features:**

- String-to-Base64 encryption
- Binary file output for interoperability
- Compatible with OpenSSL decryption

**Run:**

```bash
dart run encrypt_string.dart
```

**Output:** Creates `ciphertext_for_openssl.bin`

### 2. String Decryption (`decrypt_string.dart`)

Demonstrates decrypting RSA-OAEP encrypted data from a binary file and displaying the result as a string.

**Features:**

- Reads binary encrypted data
- Base64 display of ciphertext
- UTF-8 string output

**Run:**

```bash
dart run decrypt_string.dart
```

**Requirements:** `private.pem` and `ciphertext_for_openssl.bin`

### 3. Binary Data Encryption (`encrypt.dart`)

Shows how to encrypt raw binary data (UTF-8 bytes) and save as binary output.

**Features:**

- Direct binary data encryption
- Raw byte output
- No Base64 encoding

**Run:**

```bash
dart run encrypt.dart
```

**Output:** Creates `ciphertext.bin`

### 4. Binary Data Decryption (`decrypt.dart`)

Demonstrates decrypting raw binary encrypted data and converting back to a string.

**Features:**

- Raw binary data input
- Direct byte decryption
- UTF-8 string conversion

**Run:**

```bash
dart run decrypt.dart
```

**Requirements:** `private.pem` and `ciphertext.bin`

## Interactive Menu

The provided Makefile includes an interactive menu with multiple operations. Simply run:

```bash
make
```

This will display a menu with 13 options including:

1. Generate RSA key pair
2. Encrypt with Dart
3. Decrypt with OpenSSL  
4. Encrypt with OpenSSL
5. Decrypt with Dart
6. Clean generated files
7. Run full workflow (all steps)
8. Run full workflow and clean up
9. Encrypt with Dart (String) for OpenSSL compatibility
10. Decrypt with OpenSSL (String)
11. Complete string workflow (generate keys + encrypt + decrypt)
12. Complete string workflow with cleanup
13. Exit

## Running Individual Examples

You can also run examples directly:

```bash
# Run individual Dart scripts
dart run encrypt_string.dart
dart run decrypt_string.dart
dart run encrypt.dart
dart run decrypt.dart
```

## Automated Workflows

The Makefile provides several automated workflows:

### Complete Binary Data Workflow

```bash
# Generate keys, encrypt with Dart, decrypt with OpenSSL, 
# encrypt with OpenSSL, decrypt with Dart
make keys encrypt_dart decrypt_openssl encrypt_openssl decrypt_dart
```

### String Data Workflow  

```bash
# Generate keys, encrypt string with Dart, decrypt with OpenSSL
make keys encrypt_dart_string_bin decrypt_openssl_string
```

### Cleanup

```bash
# Remove all generated files
make clean
```

## Interoperability Testing

These examples are designed to be compatible with other RSA-OAEP implementations. You can test interoperability with OpenSSL:

### Encrypt with Dart, decrypt with OpenSSL

```bash
# After running encrypt_string.dart
openssl pkeyutl -decrypt -inkey private.pem -in ciphertext_for_openssl.bin -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256
```

### Encrypt with OpenSSL, decrypt with Dart

```bash
# Create a plaintext file first
echo "Hello from OpenSSL" > plaintext.txt

# Encrypt with OpenSSL
openssl pkeyutl -encrypt -pubin -inkey public.pem -in plaintext.txt -out ciphertext_openssl.bin -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256

# Then run decrypt.dart (modify it to read from ciphertext_openssl.bin)
```

## Key Generation Example

If you prefer to generate keys programmatically:

```dart
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

void main() {
  // Generate a 2048-bit RSA key pair
  final keyPair = RSAKeyUtils.generateKeyPair(bitLength: 2048);
  
  // Note: Converting to PEM format requires additional dependencies
  print('Public key: ${keyPair.publicKey}');
  print('Private key: ${keyPair.privateKey}');
}
```

## Security Notes

- These examples use SHA-256 as the hash function, which is recommended for production use
- Key sizes of at least 2048 bits are recommended for security
- The library includes protections against timing attacks
- Always use secure random number generation in production

## Troubleshooting

**"File not found" errors:** Make sure you have the required PEM files in the example directory.

**"Message too long" errors:** RSA-OAEP has message length limitations. For a 2048-bit key with SHA-256, the maximum message length is 190 bytes.

**Decryption errors:** Ensure you're using the correct private key that corresponds to the public key used for encryption.
