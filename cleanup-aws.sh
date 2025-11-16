#!/bin/bash

# Script para remover todos os recursos da AWS Lambda
# ATENÇÃO: Este script irá deletar permanentemente:
# - Funções Lambda
# - Sites deployados no S3
# - Buckets S3 criados pelo Remotion
# - Role IAM (opcional)

set -e

echo "⚠️  ATENÇÃO: Este script irá remover todos os recursos do Remotion Lambda na AWS"
echo ""
read -p "Tem certeza que deseja continuar? (digite 'sim' para confirmar): " confirm

if [ "$confirm" != "sim" ]; then
    echo "❌ Operação cancelada."
    exit 0
fi

echo ""
echo "🧹 Iniciando limpeza dos recursos..."
echo ""

REGION="us-east-1"

# 1. Remover todas as funções Lambda
echo "📦 Removendo funções Lambda..."
npx remotion lambda functions rmall --region "$REGION" --yes || echo "  ℹ️  Nenhuma função encontrada"

# 2. Remover todos os sites
echo "🌐 Removendo sites..."
npx remotion lambda sites rmall --region "$REGION" --yes || echo "  ℹ️  Nenhum site encontrado"

# 3. Perguntar se deseja remover o bucket principal
echo ""
read -p "Deseja remover o bucket S3 'remotion-render-ensinalab'? (s/N): " remove_bucket

if [ "$remove_bucket" = "s" ] || [ "$remove_bucket" = "S" ]; then
    echo "🗑️  Removendo bucket S3..."
    aws s3 rb s3://remotion-render-ensinalab --force || echo "  ℹ️  Bucket não encontrado"
fi

# 4. Perguntar se deseja remover a role IAM
echo ""
read -p "Deseja remover a role IAM 'remotion-lambda-role'? (s/N): " remove_role

if [ "$remove_role" = "s" ] || [ "$remove_role" = "S" ]; then
    echo "🔐 Removendo role IAM..."
    
    # Remover política da role
    aws iam delete-role-policy \
        --role-name remotion-lambda-role \
        --policy-name remotion-lambda-policy 2>/dev/null || echo "  ℹ️  Política não encontrada"
    
    # Remover role
    aws iam delete-role \
        --role-name remotion-lambda-role 2>/dev/null || echo "  ℹ️  Role não encontrada"
fi

echo ""
echo "✅ Limpeza concluída!"
echo ""
echo "Para fazer deploy novamente, execute:"
echo "  ./setup-iam.sh"
echo "  npm run lambda:functions"
echo "  npm run lambda:site"
echo ""
