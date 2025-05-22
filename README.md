# RSA OAEP Dart Library

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

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
  rsa_oaep_dart:
    git:
      url: <REPOSITÓRIO_INTERNO_GIT>
```

ou clone e copie `lib/` para seu projeto.

### Importar

```dart
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
```

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
- [ ] Publicação no pub.dev  

## 📄 Licença

MIT — veja o arquivo [LICENSE](LICENSE).
