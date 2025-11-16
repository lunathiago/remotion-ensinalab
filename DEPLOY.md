# Deploy do Remotion na AWS Lambda

Este documento descreve como fazer o deploy do projeto Remotion na AWS Lambda.

## Pré-requisitos

1. **Credenciais AWS**: Configure suas credenciais AWS usando uma das opções:
   ```bash
   # Opção 1: Variáveis de ambiente
   export AWS_ACCESS_KEY_ID="sua-chave"
   export AWS_SECRET_ACCESS_KEY="sua-secret"
   export AWS_REGION="us-east-1"
   
   # Opção 2: AWS CLI
   aws configure
   ```

2. **Bucket S3**: O bucket será criado automaticamente durante o deploy

3. **Permissões IAM**: Execute o script de setup para criar a role necessária:
   ```bash
   ./setup-iam.sh
   ```

   Alternativamente, você pode criar manualmente:
   ```bash
   aws iam create-role \
     --role-name remotion-lambda-role \
     --assume-role-policy-document file://aws-config/trust-policy.json
   
   aws iam put-role-policy \
     --role-name remotion-lambda-role \
     --policy-name remotion-lambda-policy \
     --policy-document file://aws-config/role-policy.json
   ```

## Métodos de Deploy

### Método 1: Script Automatizado (Recomendado)

Use o script `deploy-lambda.mjs` que faz todo o processo de forma automatizada:

```bash
npm run deploy:lambda
```

Este comando irá:
1. Fazer deploy da função Lambda
2. Fazer deploy do site (bundle) no S3

**Nota**: O build não é mais necessário antes do deploy, pois o Remotion faz o bundle automaticamente.

### Método 2: Deploy Manual por Etapas

#### Passo 1: Setup Inicial (apenas uma vez)
```bash
./setup-iam.sh
```

#### Passo 2: Deploy da Função Lambda
```bash
npm run lambda:functions
```

Ou manualmente:
```bash
npx remotion lambda functions deploy \
  --region us-east-1 \
  --memory 2048 \
  --timeout 120
```

#### Passo 3: Deploy do Site
```bash
npm run lambda:site
```

Ou manualmente:
```bash
npx remotion lambda sites create src/index.ts \
  --region us-east-1 \
  --site-name remotion-ensinalab
```

#### Passo 4: Listar Recursos Criados
```bash
npm run lambda:ls
```

## Renderizar Vídeo

Após o deploy, você pode renderizar vídeos usando:

```bash
npm run lambda:render
```

Ou manualmente:
```bash
npx remotion lambda render HelloWorld output.mp4 \
  --region us-east-1
```

Ou com mais opções:
```bash
npx remotion lambda render HelloWorld output.mp4 \
  --region us-east-1 \
  --codec h264 \
  --props '{"title": "Meu Vídeo"}'
```

## Status do Deploy

Você pode verificar os recursos criados com:

```bash
npm run lambda:ls
```

Isso irá listar:
- Funções Lambda deployadas
- Sites (bundles) no S3

## Listar Recursos Criados

### Listar Funções Lambda
```bash
npx remotion lambda functions ls --region us-east-1
```

### Listar Sites Deployados
```bash
npx remotion lambda sites ls --region us-east-1
```

## Remover Recursos (Cleanup)

### Remover uma Função Lambda
```bash
npx remotion lambda functions rm <function-name> --region us-east-1
```

### Remover um Site
```bash
npx remotion lambda sites rm <site-id> --region us-east-1
```

### Remover Todos os Recursos
```bash
npx remotion lambda functions rmall --region us-east-1
npx remotion lambda sites rmall --region us-east-1
```

## Custos Estimados

O custo do AWS Lambda varia conforme o uso:
- **Lambda (arm64)**: ~$0.0000133334 por GB-segundo
- **S3**: ~$0.023 por GB de armazenamento
- **Transferência de dados**: ~$0.09 por GB

Para um vídeo de 30 segundos em 1080p:
- Tempo de renderização: ~10-30 segundos
- Memória: 2GB
- Custo estimado: $0.001 - $0.003 por render

## Troubleshooting

### Erro: "MODULE_NOT_FOUND"
Certifique-se de que todas as dependências estão instaladas:
```bash
npm install
```

### Erro: "Access Denied"
Verifique se suas credenciais AWS têm as permissões necessárias.

### Erro: "Bucket not found"
Crie o bucket S3:
```bash
aws s3 mb s3://remotion-render-ensinalab --region us-east-1
```

### Timeout durante renderização
Aumente o timeout e memória da função Lambda:
```bash
npx remotion lambda functions deploy \
  --region us-east-1 \
  --memory 3009 \
  --timeout 300
```

## Configuração Adicional

Edite o arquivo `remotion.config.ts` para personalizar:
```typescript
const {defineConfig} = require('remotion');

module.exports = defineConfig({
  s3Bucket: 'seu-bucket',
  lambdaRegion: 'sua-regiao',
});
```

## Recursos

- [Documentação Oficial Remotion Lambda](https://www.remotion.dev/docs/lambda)
- [AWS Lambda Pricing](https://aws.amazon.com/lambda/pricing/)
- [Remotion CLI Reference](https://www.remotion.dev/docs/cli)
