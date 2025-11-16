#!/bin/bash

# Script para configurar IAM role para Remotion Lambda
# Execute este script uma única vez antes do primeiro deploy

set -e

echo "🔧 Configurando IAM Role para Remotion Lambda..."
echo ""

# Verificar se AWS CLI está instalado
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI não encontrado. Instale o AWS CLI primeiro."
    exit 1
fi

# Verificar se credenciais AWS estão configuradas
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ Credenciais AWS não configuradas. Configure com 'aws configure' primeiro."
    exit 1
fi

ROLE_NAME="remotion-lambda-role"
POLICY_NAME="remotion-lambda-policy"

# Verificar se role já existe
if aws iam get-role --role-name "$ROLE_NAME" &> /dev/null; then
    echo "✅ Role '$ROLE_NAME' já existe."
else
    echo "📝 Criando role '$ROLE_NAME'..."
    
    # Criar role
    aws iam create-role \
        --role-name "$ROLE_NAME" \
        --assume-role-policy-document file://aws-config/trust-policy.json \
        --description "Role for Remotion Lambda functions"
    
    echo "✅ Role criada com sucesso!"
fi

# Anexar política à role
echo "📝 Anexando política à role..."
aws iam put-role-policy \
    --role-name "$ROLE_NAME" \
    --policy-name "$POLICY_NAME" \
    --policy-document file://aws-config/role-policy.json

echo "✅ Política anexada com sucesso!"
echo ""
echo "🎉 Configuração concluída!"
echo ""
echo "Agora você pode fazer o deploy:"
echo "  npm run lambda:functions"
echo "  npm run lambda:site"
echo ""
