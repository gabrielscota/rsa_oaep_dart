import 'package:basic_utils/basic_utils.dart';

/// Utilitário para realizar o parse de chaves RSA em formato PEM.
///
/// Esta classe fornece métodos estáticos para converter strings PEM em objetos [RSAPublicKey] e [RSAPrivateKey].
class RSAKeyParser {
  /// Converte uma chave pública RSA em formato PEM para um objeto [RSAPublicKey].
  ///
  /// [pemString] - String contendo a chave pública no formato PEM.
  ///
  /// Retorna uma instância de [RSAPublicKey] pronta para uso em operações criptográficas.
  static RSAPublicKey parsePublicKeyFromPem(String pemString) {
    return CryptoUtils.rsaPublicKeyFromPem(pemString);
  }

  /// Converte uma chave privada RSA em formato PEM para um objeto [RSAPrivateKey].
  ///
  /// [pemString] - String contendo a chave privada no formato PEM.
  ///
  /// Retorna uma instância de [RSAPrivateKey] pronta para uso em operações criptográficas.
  static RSAPrivateKey parsePrivateKeyFromPem(String pemString) {
    return CryptoUtils.rsaPrivateKeyFromPem(pemString);
  }
}
