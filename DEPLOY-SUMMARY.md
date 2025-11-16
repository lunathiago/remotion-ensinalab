# ✅ Deploy na AWS Lambda - Problemas Corrigidos

## Problemas Identificados e Soluções

### 1. ❌ Problema: Comando CDK não funcionava
**Erro**: `Cannot find module '@remotion/lambda/dist/cjs/cdk/index.js'`

**Causa**: Nas versões 4.x do Remotion Lambda, o deploy via CDK foi descontinuado. O deploy agora é feito através da CLI do Remotion.

**Solução**: Substituímos o comando CDK pelos comandos corretos da CLI do Remotion Lambda.

### 2. ❌ Problema: Role IAM não existia
**Erro**: `The role defined for the function cannot be assumed by Lambda`

**Causa**: A role IAM `remotion-lambda-role` necessária não estava criada na conta AWS.

**Solução**: 
- Criamos as políticas IAM necessárias em `aws-config/`
- Criamos a role `remotion-lambda-role` com as permissões corretas
- Criamos o script `setup-iam.sh` para automatizar esse processo

### 3. ❌ Problema: Bucket S3 não existia
**Erro**: `The specified bucket does not exist`

**Causa**: O bucket S3 `remotion-render-ensinalab` não estava criado.

**Solução**: Criamos o bucket S3 na região us-east-1.

### 4. ❌ Problema: Entry point incorreto para o site
**Erro**: `This file does not contain "registerRoot"`

**Causa**: Estava sendo usado `build/index.html` como entry point, mas o correto é `src/index.ts`.

**Solução**: Corrigimos todos os scripts para usar `src/index.ts` como entry point.

## ✅ Recursos Criados com Sucesso

### 1. Função Lambda
- **Nome**: `remotion-render-4-0-375-mem2048mb-disk2048mb-120sec`
- **Região**: us-east-1
- **Memória**: 2048 MB
- **Timeout**: 120 segundos
- **Versão**: 4.0.375

### 2. Site Deployado
- **Nome**: `remotion-ensinalab`
- **Bucket**: `remotionlambda-useast1-m4t0dfhtos`
- **Tamanho**: 6.3 MB
- **URL**: https://remotionlambda-useast1-m4t0dfhtos.s3.us-east-1.amazonaws.com/sites/remotion-ensinalab/index.html

### 3. Role IAM
- **Nome**: `remotion-lambda-role`
- **ARN**: `arn:aws:iam::530282823173:role/remotion-lambda-role`
- **Permissões**: CloudWatch Logs, S3, Lambda Invoke

## 📝 Novos Arquivos Criados

1. **`deploy-lambda.mjs`**: Script Node.js para deploy automatizado
2. **`setup-iam.sh`**: Script bash para configurar IAM role
3. **`aws-config/trust-policy.json`**: Política de confiança para a role
4. **`aws-config/role-policy.json`**: Políticas de permissão para a role
5. **`DEPLOY.md`**: Documentação completa sobre o deploy
6. **`DEPLOY-SUMMARY.md`**: Este arquivo (resumo dos problemas e soluções)

## 🚀 Como Usar Agora

### Deploy Completo
```bash
# 1. Configure IAM (apenas uma vez)
./setup-iam.sh

# 2. Deploy da função Lambda
npm run lambda:functions

# 3. Deploy do site
npm run lambda:site

# 4. Verificar recursos criados
npm run lambda:ls
```

### Renderizar Vídeo
```bash
npm run lambda:render
```

Ou com opções customizadas:
```bash
npx remotion lambda render HelloWorld meu-video.mp4 \
  --region us-east-1 \
  --codec h264
```

## 📊 Scripts Disponíveis no package.json

```json
{
  "deploy:lambda": "node deploy-lambda.mjs",
  "lambda:functions": "npx remotion lambda functions deploy --region us-east-1 --memory 2048 --timeout 120",
  "lambda:site": "npx remotion lambda sites create src/index.ts --region us-east-1 --site-name remotion-ensinalab",
  "lambda:ls": "npx remotion lambda functions ls --region us-east-1 && npx remotion lambda sites ls --region us-east-1",
  "lambda:render": "npx remotion lambda render HelloWorld output.mp4 --region us-east-1"
}
```

## 🔍 Comandos Úteis

```bash
# Listar funções Lambda
npx remotion lambda functions ls --region us-east-1

# Listar sites deployados
npx remotion lambda sites ls --region us-east-1

# Remover função Lambda
npx remotion lambda functions rm <function-name> --region us-east-1

# Remover site
npx remotion lambda sites rm <site-name> --region us-east-1

# Ver composições disponíveis
npx remotion lambda compositions --region us-east-1

# Verificar status de um render
npx remotion lambda renders <render-id> --region us-east-1
```

## 💰 Custos Estimados

- **Lambda (arm64, 2048 MB)**: ~$0.0000133334 por GB-segundo
- **S3 Storage**: ~$0.023 por GB/mês
- **S3 Requests**: ~$0.0004 por 1000 requests

**Exemplo**: Renderizar um vídeo de 30 segundos custaria aproximadamente $0.001 - $0.003

## 📚 Documentação

- Para mais detalhes, veja: [DEPLOY.md](./DEPLOY.md)
- Documentação oficial: https://www.remotion.dev/docs/lambda
- Troubleshooting: https://www.remotion.dev/docs/lambda/troubleshooting

## ✅ Status Atual

- [x] AWS CLI instalado e configurado
- [x] Credenciais AWS configuradas
- [x] Bucket S3 criado
- [x] Role IAM configurada
- [x] Função Lambda deployada
- [x] Site deployado no S3
- [x] Scripts de automação criados
- [x] Documentação completa

**Tudo pronto para começar a renderizar vídeos na AWS Lambda! 🎉**
