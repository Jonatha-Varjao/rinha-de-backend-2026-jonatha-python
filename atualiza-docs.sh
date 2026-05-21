#!/bin/bash

# 1. Cria uma pasta temporária limpa
TMP_DIR=$(mktemp -d)

# 2. Clona o repositório de forma parcial (bloqueando blobs pesados) e ativa o filtro
git clone --depth 1 --filter=blob:none --sparse https://github.com/zanfranceschi/rinha-de-backend-2026 "$TMP_DIR"

# 3. Entra na pasta temporária e baixa APENAS a pasta docs/
cd "$TMP_DIR" || exit
git sparse-checkout set docs

# 4. Volta para a raiz do seu projeto, remove os docs antigos e copia os novos
cd - || exit
rm -rf docs
cp -r "$TMP_DIR/docs" ./docs

# 5. Limpa a pasta temporária do computador
rm -rf "$TMP_DIR"

echo "✅ Pasta docs-rinha atualizada com sucesso!"