# Changelog

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
