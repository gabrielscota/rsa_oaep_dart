# RSA OAEP Dart Library

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Pub Version](https://img.shields.io/pub/v/rsa_oaep_dart.svg)](https://pub.dev/packages/rsa_oaep_dart)
[![Test](https://github.com/gabrielscota/rsa_oaep_dart/actions/workflows/test.yml/badge.svg)](https://github.com/gabrielscota/rsa_oaep_dart/actions/workflows/test.yml)
[![Dart SDK](https://img.shields.io/badge/Dart-%3E%3D3.0.0-blue)](https://dart.dev)
[![codecov](https://codecov.io/gh/gabrielscota/rsa_oaep_dart/branch/main/graph/badge.svg)](https://codecov.io/gh/gabrielscota/rsa_oaep_dart)

Implementação completa e pura de **RSAES-OAEP** (PKCS#1 v2.2) em **Dart**, com suporte a **SHA-256**.  
Ideal para projetos que precisam de **criptografia assimétrica segura**, sem dependências nativas.

## 🚀 Funcionalidades

✅ Suporte ao esquema **RSAES-OAEP** com MGF1.  
✅ Compatível com **SHA-256** (default).  
✅ Interoperável com **OpenSSL** (criptografia e descriptografia).  
✅ Testes automatizados e exemplos práticos.  
✅ Código puro Dart, ideal para Flutter e backend.

## 📦 Estrutura

- `lib/src/` → Implementação da biblioteca.  
- `test/` → Testes automatizados com `package:test`.  
- `lib/example/` → Scripts de exemplo (`encrypt.dart`, `decrypt.dart`), `Makefile` e arquivos gerados.

## 🛠️ Como usar

### Instalar

Adicione ao `pubspec.yaml`:

```yaml
dependencies:
  rsa_oaep_dart: ^0.1.1
```

Disponível no [pub.dev](https://pub.dev/packages/rsa_oaep_dart).

### Importar

```dart
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
```

Veja mais detalhes na [documentação oficial](https://pub.dev/documentation/rsa_oaep_dart/latest/).

## 📦 Compatibilidade

Esta biblioteca é compatível com **Dart SDK 3.0.0 ou superior**.

Dart 3.0.0 foi lançado em maio de 2023, junto com **Flutter 3.10**.  
Portanto, este pacote é compatível com projetos que utilizam:  

- **Dart**: >=3.0.0 <4.0.0  
- **Flutter**: >=3.10.0

Se o seu projeto ainda utiliza uma versão anterior do Dart ou Flutter, será necessário atualizá-lo para utilizar este pacote.

## 💻 Exemplos

### Executar exemplos completos

```bash
cd lib/example
make
```

### Menu interativo

```bash
make
```

Inclui:  

- Geração de chaves  
- Criptografia com Dart e OpenSSL  
- Descriptografia com Dart e OpenSSL  

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

## ✅ Roadmap

- [ ] Suporte a SHA-1, SHA-512  
- [ ] Suporte a labels customizados  
- [ ] Automatização com CI/CD  

## 📄 Licença

MIT — veja o arquivo [LICENSE](LICENSE).

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

## 📊 Integração com Codecov

Este projeto utiliza [Codecov](https://codecov.io/) para monitoramento de **cobertura de testes**.

A cada `push` ou `pull request` para a branch `main`, o **GitHub Actions** executa automaticamente:

- Análise de código
- Testes automatizados
- Geração de relatório de cobertura (`lcov.info`)
- Upload para o Codecov

O badge no topo deste README exibe a cobertura atualizada.

Para visualizar o relatório completo, acesse:  
[https://codecov.io/gh/gabrielscota/rsa_oaep_dart](https://codecov.io/gh/gabrielscota/rsa_oaep_dart)
