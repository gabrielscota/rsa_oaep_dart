KEY_SIZE = 2048
PRIVATE_KEY = private.pem
PUBLIC_KEY = public.pem
PLAINTEXT = plaintext.txt
CIPHERTEXT_DART = ciphertext.bin
CIPHERTEXT_OPENSSL = ciphertext_openssl.bin
PLAINTEXT_OUT = plaintext_out.txt

all:
	@echo "\033[1;34m🛠️  Menu de operações RSA OAEP:\033[0m"; \
	echo ""; \
	echo "1) Gerar par de chaves RSA"; \
	echo "2) Criptografar com Dart"; \
	echo "3) Descriptografar com OpenSSL"; \
	echo "4) Criptografar com OpenSSL"; \
	echo "5) Descriptografar com Dart"; \
	echo "6) Limpar arquivos gerados"; \
	echo "7) Executar todos os passos"; \
	echo "8) Executar todos os passos e limpar arquivos"; \
	echo "9) Criptografar com Dart (String) e preparar para OpenSSL"; \
	echo "10) Descriptografar com OpenSSL (String)"; \
	echo "11) Executar: gerar chaves, criptografar com Dart (String), descriptografar com OpenSSL (String)"; \
	echo "12) Executar: gerar chaves, criptografar com Dart (String), descriptografar com OpenSSL (String) e limpar arquivos"; \
	echo "13) Sair"; \
	echo ""; \
	read -p "$(echo -e '\033[1;33mEscolha uma opção [1-13]: \033[0m')" opt; \
	case $$opt in \
		1) $(MAKE) keys ;; \
		2) $(MAKE) encrypt_dart ;; \
		3) $(MAKE) decrypt_openssl ;; \
		4) $(MAKE) encrypt_openssl ;; \
		5) $(MAKE) decrypt_dart ;; \
		6) $(MAKE) clean ;; \
		7) $(MAKE) keys encrypt_dart decrypt_openssl encrypt_openssl decrypt_dart ;; \
		8) $(MAKE) keys encrypt_dart decrypt_openssl encrypt_openssl decrypt_dart clean ;; \
		9) $(MAKE) encrypt_dart_string_bin ;; \
		10) $(MAKE) decrypt_openssl_string ;; \
		11) $(MAKE) keys encrypt_dart_string_bin decrypt_openssl_string ;; \
		12) $(MAKE) keys encrypt_dart_string_bin decrypt_openssl_string clean ;; \
		13) echo "\033[1;31mSaindo...\033[0m"; exit 0 ;; \
		*) echo "\033[1;31mOpção inválida\033[0m"; exit 1 ;; \
	esac

keys:
	@echo "\033[1;34m🔑 Gerando par de chaves RSA...\033[0m"
	@echo ""
	openssl genpkey -algorithm RSA -out $(PRIVATE_KEY) -pkeyopt rsa_keygen_bits:$(KEY_SIZE)
	openssl rsa -pubout -in $(PRIVATE_KEY) -out $(PUBLIC_KEY)
	@echo ""

encrypt_dart: $(PUBLIC_KEY)
	@echo "\033[1;34m🔐 Criptografando com Dart...\033[0m"
	@echo ""
	printf "Hello, Gabriel!" > $(PLAINTEXT)
	dart run encrypt.dart
	@echo ""

decrypt_openssl: $(PRIVATE_KEY) $(CIPHERTEXT_DART)
	@echo "\033[1;34m🔓 Descriptografando com OpenSSL...\033[0m"
	@echo ""
	openssl pkeyutl -decrypt \
		-inkey $(PRIVATE_KEY) \
		-in $(CIPHERTEXT_DART) \
		-out $(PLAINTEXT_OUT) \
		-pkeyopt rsa_padding_mode:oaep \
		-pkeyopt rsa_oaep_md:sha256
	@echo ""
	@echo "\033[1;32m✅ Resultado: $$(cat $(PLAINTEXT_OUT))\033[0m"
	@echo ""

encrypt_openssl: $(PUBLIC_KEY) $(PLAINTEXT)
	@echo "\033[1;34m🔐 Criptografando com OpenSSL...\033[0m"
	@echo ""
	openssl pkeyutl -encrypt \
		-pubin -inkey $(PUBLIC_KEY) \
		-in $(PLAINTEXT) \
		-out $(CIPHERTEXT_OPENSSL) \
		-pkeyopt rsa_padding_mode:oaep \
		-pkeyopt rsa_oaep_md:sha256
	@echo ""

decrypt_dart: $(PRIVATE_KEY) $(CIPHERTEXT_OPENSSL)
	@echo "\033[1;34m🔓 Descriptografando com Dart...\033[0m"
	@echo ""
	dart run decrypt.dart
	@echo ""

encrypt_dart_string: $(PUBLIC_KEY)
	@echo "\033[1;34m🔐 Criptografando com Dart (String)...\033[0m"
	@echo ""
	dart run encrypt_string.dart
	@echo ""

decrypt_dart_string: $(PRIVATE_KEY)
	@echo "\033[1;34m🔓 Descriptografando com Dart (String)...\033[0m"
	@echo ""
	dart run decrypt_string.dart
	@echo ""

encrypt_dart_string_bin: $(PUBLIC_KEY)
	@echo "\033[1;34m🔐 Criptografando com Dart (String, preparando binário para OpenSSL)...\033[0m"
	@echo ""
	dart run encrypt_string.dart
	@echo ""

decrypt_openssl_string: $(PRIVATE_KEY) ciphertext_for_openssl.bin
	@echo "\033[1;34m🔓 Descriptografando com OpenSSL (String)...\033[0m"
	@echo ""
	openssl pkeyutl -decrypt \
		-inkey $(PRIVATE_KEY) \
		-in ciphertext_for_openssl.bin \
		-out plaintext_out.txt \
		-pkeyopt rsa_padding_mode:oaep \
		-pkeyopt rsa_oaep_md:sha256
	@echo ""
	@echo "\033[1;32m✅ Resultado: $$(cat plaintext_out.txt)\033[0m"
	@echo ""

clean:
	@echo "\033[1;34m🧹 Limpando arquivos...\033[0m"
	@echo ""
	rm -f $(PRIVATE_KEY) $(PUBLIC_KEY) $(CIPHERTEXT_DART) $(CIPHERTEXT_OPENSSL) $(PLAINTEXT) $(PLAINTEXT_OUT) ciphertext_for_openssl.bin
	@echo ""