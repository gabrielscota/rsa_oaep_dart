import 'dart:typed_data';

/// Converts an octet string to a nonnegative integer.
///
/// This function implements the OS2IP (Octet String to Integer Primitive)
/// conversion as defined in RFC 3447. It converts a byte array to a BigInt
/// by interpreting the bytes as a big-endian unsigned integer.
///
/// Parameters:
/// - [x]: The octet string (byte array) to convert
///
/// Returns a [BigInt] representing the integer value of the octet string.
///
/// The conversion treats the byte array as a hexadecimal string where each
/// byte is represented as a two-digit hex value, then parses it as a BigInt.
///
/// Example:
/// ```dart
/// final bytes = Uint8List.fromList([0x01, 0x23, 0x45]);
/// final integer = os2ip(bytes); // Returns BigInt representing 0x012345
/// ```
///
/// See also:
/// - RFC 3447 section 4.2 for the OS2IP specification
/// - [i2osp] for the inverse operation (integer to octet string)
BigInt os2ip(Uint8List x) {
  return BigInt.parse(x.map((e) => e.toRadixString(16).padLeft(2, '0')).join(), radix: 16);
}

/// Converts a nonnegative integer to an octet string of specified length.
///
/// This function implements the I2OSP (Integer to Octet String Primitive)
/// conversion as defined in RFC 3447. It converts a BigInt to a byte array
/// of the specified length, representing the integer in big-endian format.
///
/// Parameters:
/// - [x]: The nonnegative integer to convert
/// - [xLen]: The intended length of the resulting octet string in bytes
///
/// Returns a [Uint8List] of length [xLen] containing the big-endian
/// representation of the integer.
///
/// The integer is converted to a hexadecimal string, padded with leading
/// zeros to match the required byte length, then converted to bytes.
///
/// If the integer is too large to fit in [xLen] bytes, the result will
/// be truncated (though this should be avoided in practice).
///
/// Example:
/// ```dart
/// final integer = BigInt.parse('012345', radix: 16);
/// final bytes = i2osp(integer, 4); // Returns [0x00, 0x01, 0x23, 0x45]
/// ```
///
/// See also:
/// - RFC 3447 section 4.1 for the I2OSP specification
/// - [os2ip] for the inverse operation (octet string to integer)
Uint8List i2osp(BigInt x, int xLen) {
  final bytes = x.toRadixString(16).padLeft(xLen * 2, '0');
  return Uint8List.fromList(List.generate(xLen, (i) => int.parse(bytes.substring(i * 2, i * 2 + 2), radix: 16)));
}
