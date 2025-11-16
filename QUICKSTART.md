# 🚀 Guia Rápido - Deploy AWS Lambda

## Início Rápido (5 minutos)

### 1️⃣ Configure as credenciais AWS
```bash
aws configure
# Digite: Access Key, Secret Key, Region (us-east-1), Output format (json)
```

### 2️⃣ Configure a IAM Role (apenas uma vez)
```bash
./setup-iam.sh
```

### 3️⃣ Deploy da função Lambda
```bash
npm run lambda:functions
```
⏱️ Tempo estimado: ~2 minutos

### 4️⃣ Deploy do site
```bash
npm run lambda:site
```
⏱️ Tempo estimado: ~1 minuto

### 5️⃣ Renderize seu primeiro vídeo! 🎉
```bash
npm run lambda:render
```
⏱️ Tempo estimado: ~30 segundos

---

## Comandos Úteis

```bash
# Ver recursos criados
npm run lambda:ls

# Renderizar com nome personalizado
npx remotion lambda render HelloWorld meu-video.mp4 --region us-east-1

# Ver todas as composições disponíveis
npx remotion lambda compositions --region us-east-1
```

---

## Custos Aproximados

💰 **Lambda**: ~$0.002 por renderização de 30 segundos  
💰 **S3**: ~$0.023 por GB/mês de armazenamento  
💰 **Total estimado**: < $0.01 por vídeo renderizado

---

## Troubleshooting

❌ **"Access Denied"**  
→ Execute `aws configure` e verifique suas credenciais

❌ **"Role cannot be assumed"**  
→ Execute `./setup-iam.sh` novamente

❌ **"Function not found"**  
→ Execute `npm run lambda:functions` primeiro

---

## Documentação Completa

📖 Veja [DEPLOY.md](./DEPLOY.md) para instruções detalhadas  
📖 Veja [DEPLOY-SUMMARY.md](./DEPLOY-SUMMARY.md) para resumo dos problemas resolvidos

---

## Status do Deploy

✅ AWS CLI instalado  
✅ Credenciais configuradas  
✅ Bucket S3: `remotion-render-ensinalab`  
✅ Role IAM: `remotion-lambda-role`  
✅ Função Lambda: `remotion-render-4-0-375-mem2048mb-disk2048mb-120sec`  
✅ Site: `remotion-ensinalab`

**Pronto para renderizar! 🎬**
