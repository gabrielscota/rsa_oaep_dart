# Changelog

<!-- markdownlint-disable MD024 -->

## [0.1.6] - 2025-08-13

### Changed

- README principal traduzido para inglês e reorganizado (Features, Getting started, Examples, Interoperability, Security, Roadmap, Contributing).
- Versão de dependência no snippet do README atualizada para `^0.1.6`.
- Alinhamento do README com os exemplos da pasta `example/` e com o Makefile (menu interativo e workflows).

### Documentation

- Melhor clareza nas seções de interoperabilidade (conversão UTF-8, Base64, limites de tamanho e métodos de conveniência).
- Exemplos de código revisados para consistência.

## [0.1.5] - 2025-05-25

### Added

- Documentação completa da API em inglês seguindo as diretrizes do Dart/Flutter para todos os métodos e classes públicas.
- Documentação detalhada da biblioteca principal (`rsa_oaep_dart.dart`) com seções de recursos, início rápido, interoperabilidade e notas de segurança.
- README completo na pasta `example/` explicando como usar todos os exemplos práticos e comandos do Makefile.
- Exemplos de uso em todas as funções e classes da API.
- Referências cruzadas entre classes relacionadas na documentação.
- Seções "See also" em métodos principais com links para RFC 3447 e classes relacionadas.

### Improved

- README principal expandido com seções mais detalhadas sobre funcionalidades, boas práticas e roadmap.
- Documentação da classe `RSAOAEP` com exemplos práticos de criptografia/descriptografia e cálculos de tamanho máximo de mensagem.
- Documentação da classe `RSAKeyUtils` com orientações de segurança sobre tamanhos de chave e parâmetros.
- Documentação da classe `RSAKeyParser` com exemplos de uso e tratamento de exceções.
- Documentação da função `mgf1` com explicação detalhada do algoritmo e referências ao RFC.
- Documentação das funções utilitárias `os2ip` e `i2osp` com exemplos práticos e contexto criptográfico.

### Enhanced

- Todos os exemplos (`encrypt.dart`, `decrypt.dart`, `encrypt_string.dart`, `decrypt_string.dart`) agora possuem documentação completa explicando o fluxo de execução.
- README do exemplo atualizado para ser consistente com os comandos reais disponíveis no Makefile.
- Seção de contribuição expandida no README principal com guia passo-a-passo.
- Seção de suporte adicionada com links organizados para documentação, exemplos e issues.

### Documentation

- Todas as classes, métodos e funções públicas agora seguem as convenções de documentação do Dart (`///`).
- Exemplos de código adicionados em todas as funções principais.
- Parâmetros, valores de retorno e exceções documentados consistentemente.
- Notas de segurança e interoperabilidade incluídas onde relevante.

## [0.1.4] - 2025-05-22

### Added

- Métodos `encryptString` e `decryptString` adicionados na classe `RSAOAEP` para facilitar operações diretas com `String` e integração com sistemas que utilizam Base64.
- Testes automatizados para `encryptString` e `decryptString`, garantindo cobertura total.
- Fluxo automatizado no `Makefile` para criptografar `String` com Dart, gerar binário compatível e descriptografar com OpenSSL.

## [0.1.3] - 2025-05-22

### Added

- Criação da classe `RSAKeyUtils` para organização de métodos auxiliares relacionados a chaves.
- Método `generateKeyPair` adicionado em `RSAKeyUtils`, com parâmetros configuráveis: `publicExponent`, `bitLength` e `certainty`.
- Testes automatizados para `RSAKeyUtils.generateKeyPair`, garantindo cobertura de 100%.
- Nova documentação no método `generateKeyPair`, incluindo exemplo de uso e explicação dos parâmetros.

### Changed

- Refatoração: método `generateKeyPair` movido de `RSAOAEP` para `RSAKeyUtils` para respeitar o princípio da responsabilidade única (SRP).
- Atualização dos testes: descrições dos casos de teste agora em inglês e mais descritivas.

## [0.1.2] - 2025-05-22

### Added

- Refatoração da classe `RSAOAEP`: agora stateless, métodos recebem chaves e labels diretamente.
- Documentação aprimorada para todas as classes, incluindo exemplos de uso e observações sobre interoperabilidade.
- Nova seção "Interoperabilidade & Boas Práticas" no README, orientando sobre conversão de mensagens para bytes e integração com sistemas externos (ex: KMS).
- Badge de compatibilidade com Dart e badge de cobertura de testes (Codecov) adicionados ao README.
- Explicação sobre integração com Codecov adicionada ao README.
- Orientações sobre convenção de commits (Conventional Commits/Gitmoji) e hooks automáticos no CONTRIBUTING.md.

### Changed

- README reorganizado para melhor fluxo e clareza.
- Aviso de segurança movido para posição mais destacada.
- Pequenas melhorias de texto e padronização nas documentações.

### Fixed

- Ajuste no workflow do GitHub Actions para integração correta com Codecov usando token e slug.
- Correção na documentação do CHANGELOG.md e CONTRIBUTING.md.

## [0.1.1] - 2025-05-22

### Added

- Aviso de segurança no `README.md` sobre limites da implementação pura em Dart.

## [0.1.0] - 2025-05-22

### Added

- Implementação completa de RSAES-OAEP com MGF1.
- Suporte a criptografia e descriptografia com SHA-256.
- Interoperabilidade garantida com OpenSSL (pkeyutl).
- Testes automatizados para casos normais e de falha.
- Exemplo completo com `Makefile` interativo.

### Changed

- Estrutura reorganizada para separar código da lib, exemplos e testes.

### Fixed

- Correção no parser de chaves PEM com `basic_utils`.
