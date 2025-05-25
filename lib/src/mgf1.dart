import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Implements the MGF1 mask generation function as defined in RFC 3447.
///
/// MGF1 is a cryptographic mask generation function used in RSA-OAEP padding.
/// It generates a deterministic pseudo-random octet string of specified length
/// from a given seed using a hash function.
///
/// The function works by:
/// 1. Computing the number of hash iterations needed based on desired length
/// 2. For each iteration, concatenating the seed with a 4-byte counter
/// 3. Hashing the concatenated data and appending to output
/// 4. Truncating the final output to the requested length
///
/// Parameters:
/// - [seed]: The input seed bytes to generate the mask from
/// - [length]: The desired length of the output mask in bytes
/// - [hash]: The hash function to use (typically SHA-256)
///
/// Returns:
/// A [Uint8List] containing the generated mask of the specified length.
///
/// Example:
/// ```dart
/// final seed = Uint8List.fromList([1, 2, 3, 4]);
/// final mask = mgf1(seed, 32, SHA256Digest());
/// ```
///
/// See also:
/// - RFC 3447 section 4.1 for the complete MGF1 specification
/// - [RSAOAEP] which uses this function for padding operations
Uint8List mgf1(Uint8List seed, int length, Digest hash) {
  final hLen = hash.digestSize;
  final count = (length / hLen).ceil();
  final output = BytesBuilder();

  for (var i = 0; i < count; i++) {
    // Convert counter to 4-byte big-endian representation
    final c = Uint8List(4)
      ..[0] = (i >> 24) & 0xFF
      ..[1] = (i >> 16) & 0xFF
      ..[2] = (i >> 8) & 0xFF
      ..[3] = i & 0xFF;

    // Concatenate seed with counter and hash the result
    final data = Uint8List.fromList(seed + c);
    output.add(hash.process(data));
  }

  // Truncate output to requested length
  final outputBytes = output.toBytes();
  return Uint8List.fromList(outputBytes.sublist(0, length));
}
