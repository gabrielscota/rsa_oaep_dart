# 🤝 Contribuindo com RSA OAEP Dart

Obrigado por considerar contribuir com este projeto!  
A seguir estão algumas orientações para facilitar sua colaboração e manter a qualidade do código.

---

## 🛠️ Como contribuir

1. **Fork** este repositório.
2. **Crie uma branch** descritiva para sua feature ou correção:

   ```bash
   git checkout -b minha-feature
   ```

3. **Implemente** sua modificação.
4. **Adicione testes** que validem a alteração.
5. **Garanta** que todos os testes passam:

   ```bash
   dart test
   ```

6. **Atualize** o `CHANGELOG.md` com a descrição da mudança.
7. **Envie um Pull Request** com uma descrição clara da motivação e mudanças.

---

## ✅ Requisitos para contribuição

- **Formatação**: código deve seguir o padrão oficial do Dart:

  ```bash
  dart format .
  dart analyze
  ```

- **Testes**:  
  ✅ Todos os testes existentes devem passar.  
  ✅ Novos recursos ou correções **devem incluir testes** que comprovem a mudança.

- **Documentação**:  
  ✅ Atualize comentários de documentação quando necessário.  

---

## 📝 Reportando problemas

Abra uma **issue** descrevendo:  

- O comportamento observado.  
- O comportamento esperado.  
- Passos para reproduzir o problema.  

---

## 💡 Sugestões de contribuição

- Melhorar a compatibilidade com outras bibliotecas de criptografia.  
- Adicionar suporte a novos algoritmos de hash.  
- Otimizações de desempenho.  
- Aprimorar a documentação.  

---

## 🧪 Testes e Qualidade

- Toda contribuição deve incluir ou atualizar **testes automatizados**.  
- Sempre execute:  

  ```bash
  dart format .
  dart analyze
  dart test
  ```

- Atualize o `CHANGELOG.md` com um breve resumo da mudança.  

---

## 📝 Padrão de Commits

Este projeto segue a convenção de commits **Conventional Commits** para manter um histórico claro e facilitar a automação de changelogs e versionamento semântico.

### Tipos de commit

- **feat**: Para novas funcionalidades.
- **fix**: Para correções de bugs.
- **docs**: Para mudanças na documentação.
- **style**: Para mudanças de formatação que não afetam a lógica do código.
- **refactor**: Para mudanças internas que não adicionam nem corrigem funcionalidades.
- **test**: Para adição ou modificação de testes.
- **chore**: Para mudanças na configuração, CI/CD ou tarefas auxiliares.

### Exemplos

```bash
git commit -m "feat: adicionar suporte a labels customizados"
git commit -m "fix: corrigir bug no parser de chave privada"
git commit -m "docs: atualizar README com aviso de segurança"
git commit -m "test: adicionar casos de borda no MGF1"
git commit -m "chore: configurar GitHub Actions com Codecov"
```

---

## 🤝 Código de Conduta

Por favor, seja respeitoso e colaborativo.  
Este projeto adota um código de conduta baseado no [Contributor Covenant](https://www.contributor-covenant.org/).

---

Obrigado por ajudar a melhorar este projeto!
