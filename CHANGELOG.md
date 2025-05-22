# Changelog

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
