# RSA OAEP Dart Library

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Pub Version](https://img.shields.io/pub/v/rsa_oaep_dart.svg)](https://pub.dev/packages/rsa_oaep_dart)
[![Test](https://github.com/gabrielscota/rsa_oaep_dart/actions/workflows/test.yml/badge.svg)](https://github.com/gabrielscota/rsa_oaep_dart/actions/workflows/test.yml)
[![Dart SDK](https://img.shields.io/badge/Dart-%3E%3D3.0.0-blue)](https://dart.dev)
[![codecov](https://codecov.io/gh/gabrielscota/rsa_oaep_dart/branch/main/graph/badge.svg)](https://codecov.io/gh/gabrielscota/rsa_oaep_dart)

Implementação completa e pura de **RSAES-OAEP** (PKCS#1 v2.2) em **Dart**, com suporte a **SHA-256**.  
Ideal para projetos que precisam de **criptografia assimétrica segura**, sem dependências nativas.

> **🎯 Perfeito para Flutter, web e backend** - Funciona em todas as plataformas suportadas pelo Dart

## 📦 Compatibilidade

Esta biblioteca é compatível com **Dart SDK 3.0.0 ou superior**.

Dart 3.0.0 foi lançado em maio de 2023, junto com **Flutter 3.10**.  
Portanto, este pacote é compatível com projetos que utilizam:  

- **Dart**: >=3.0.0 <4.0.0  
- **Flutter**: >=3.10.0

Se o seu projeto ainda utiliza uma versão anterior do Dart ou Flutter, será necessário atualizá-lo para utilizar este pacote.

## 🚀 Funcionalidades

✅ **Criptografia RSA-OAEP** com MGF1 conforme RFC 8017  
✅ **SHA-256** como função hash (padrão recomendado)  
✅ **Interoperabilidade** total com OpenSSL e outras bibliotecas  
✅ **Geração de chaves** RSA segura (2048, 3072, 4096 bits)  
✅ **Parser de chaves PEM** para importação/exportação  
✅ **API simples** para strings e dados binários  
✅ **Código puro Dart** - funciona em Flutter, web e backend  
✅ **Testes abrangentes** com cobertura de código  
✅ **Exemplos práticos** e documentação completa

## 🛠️ Como usar

### 📦 Instalação

Adicione ao seu `pubspec.yaml`:

```yaml
dependencies:
  rsa_oaep_dart: ^0.1.5
```

Execute:

```bash
dart pub get
```

### 📥 Importação

```dart
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
```

### 📖 Documentação

Veja a documentação completa da API em [pub.dev](https://pub.dev/documentation/rsa_oaep_dart/latest/).

## 💻 Exemplos

### Uso básico

```dart
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

// Gerar par de chaves
final keyPair = RSAKeyUtils.generateKeyPair(bitLength: 2048);

// Criar instância OAEP com SHA-256
final oaep = RSAOAEP(hash: SHA256Digest());

// Criptografar mensagem
final message = 'Olá, mundo!';
final encrypted = oaep.encryptString(message, keyPair.publicKey);

// Descriptografar mensagem
final decrypted = oaep.decryptString(encrypted, keyPair.privateKey);
print(decrypted); // Output: Olá, mundo!
```

### Executar exemplos completos

```bash
cd example
make
```

### Menu interativo

```bash
make
```

Inclui:  

- Geração de chaves RSA
- Criptografia com Dart e OpenSSL  
- Descriptografia com Dart e OpenSSL
- Testes de interoperabilidade  

## 🧪 Testes

```bash
dart test
```

## ✅ Conformidade

- RFC 8017 — PKCS#1 v2.2  
- MGF1 com SHA-256  
- Compatível com `openssl pkeyutl` para interoperabilidade.

## 🔒 Segurança

Esta implementação segue as boas práticas de segurança para operações criptográficas:  

- Geração segura de chaves  
- Uso correto de OAEP e MGF1  
- Tratamento de mensagens inválidas

## 📚 Interoperabilidade & Boas Práticas

### 🔄 Conversão de mensagens

Para garantir interoperabilidade com sistemas externos (AWS KMS, OpenSSL, Java, Python, etc.):

**✅ Para criptografar:**

```dart
// Sempre converta string para bytes UTF-8
final messageBytes = Uint8List.fromList(utf8.encode('Sua mensagem'));
final encrypted = oaep.encrypt(messageBytes, publicKey);
```

**✅ Para descriptografar:**

```dart
// O resultado é sempre bytes
final decryptedBytes = oaep.decrypt(ciphertext, privateKey);
// Converta de volta para string se necessário
final message = utf8.decode(decryptedBytes);
```

### 📡 Transmissão e armazenamento

Para transmitir ou armazenar dados criptografados:

```dart
// Encode em Base64 para transmissão/armazenamento
final ciphertextBase64 = base64.encode(ciphertext);

// Decode Base64 antes de descriptografar
final ciphertext = base64.decode(ciphertextBase64);
```

### ⚡ Métodos de conveniência

Para facilitar o uso com strings:

```dart
// Criptografar string diretamente (retorna Base64)
final encryptedBase64 = oaep.encryptString('Mensagem', publicKey);

// Descriptografar Base64 diretamente (retorna string)
final decrypted = oaep.decryptString(encryptedBase64, privateKey);
```

### 🔐 Limitações de tamanho

RSA-OAEP tem limitações de tamanho da mensagem:

- **Chave 2048-bit + SHA-256**: máximo 190 bytes
- **Chave 3072-bit + SHA-256**: máximo 318 bytes  
- **Chave 4096-bit + SHA-256**: máximo 446 bytes

Para mensagens maiores, use criptografia híbrida (RSA + AES).

## ⚠️ Aviso de Segurança

Esta biblioteca é uma **implementação pura em Dart** dos algoritmos RSA OAEP com MGF1 e SHA-256.  
Ela **não foi auditada** por especialistas em segurança para uso em ambientes críticos ou produção sensível.  

**Recomenda-se**:  
✅ Revisão do código por especialistas antes de uso em sistemas de segurança sensível.  
✅ Utilização consciente das limitações de uma implementação em linguagem de alto nível como Dart.  

Esta biblioteca é ideal para:  

- Prototipagem  
- Estudos  
- Aplicações não críticas

Mas pode **não ser adequada** para casos onde segurança formalmente auditada é obrigatória.

## ✅ Roadmap

- [ ] Suporte a **SHA-1** e **SHA-512**  
- [ ] Suporte a **labels customizados** no OAEP  
- [ ] **Benchmarks** de performance  
- [ ] **Exemplos Flutter** com interface gráfica  
- [ ] **Auditoria de segurança** profissional

## 🤝 Contribuindo

Contribuições são bem-vindas! Veja o [CONTRIBUTING.md](CONTRIBUTING.md) para diretrizes.

### Como contribuir

1. Fork o projeto
2. Crie uma branch: `git checkout -b feature/nova-funcionalidade`
3. Commit suas mudanças: `git commit -m 'Adiciona nova funcionalidade'`
4. Push para a branch: `git push origin feature/nova-funcionalidade`
5. Abra um Pull Request  

## 📄 Licença

MIT — veja o arquivo [LICENSE](LICENSE).
