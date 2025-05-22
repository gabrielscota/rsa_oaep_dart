all:
	@echo "\033[1;34m🛠️  Menu de operações do RSA OAEP Dart:\033[0m"; \
	echo ""; \
	echo "1) Validar (formatar, analisar, testar, dry-run)"; \
	echo "2) Publicar pacote"; \
	echo "3) Sair"; \
	echo ""; \
	read -p "$(echo -e '\033[1;33mEscolha uma opção [1-3]: \033[0m')" opt; \
	case $$opt in \
		1) $(MAKE) validate ;; \
		2) $(MAKE) publish ;; \
		3) echo "\033[1;31mSaindo...\033[0m"; exit 0 ;; \
		*) echo "\033[1;31mOpção inválida\033[0m"; exit 1 ;; \
	esac

validate:
	@echo "✅ Formatando o código..."
	dart format .
	@echo ""
	@echo "✅ Analisando o código..."
	dart analyze
	@echo ""
	@echo "✅ Executando testes..."
	dart test
	@echo ""
	@echo "✅ Checando possibilidade de publicação..."
	dart pub publish --dry-run

publish: validate
	@echo "🚀 Publicando o pacote..."
	dart pub publish