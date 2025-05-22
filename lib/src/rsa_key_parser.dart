import 'package:basic_utils/basic_utils.dart';

class RSAKeyParser {
  /// Parse a PEM formatted RSA public key into RSAPublicKey
  static RSAPublicKey parsePublicKeyFromPem(String pemString) {
    return CryptoUtils.rsaPublicKeyFromPem(pemString);
  }

  /// Parse a PEM formatted RSA private key into RSAPrivateKey
  static RSAPrivateKey parsePrivateKeyFromPem(String pemString) {
    return CryptoUtils.rsaPrivateKeyFromPem(pemString);
  }
}
