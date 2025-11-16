#!/bin/bash

# Script de exemplo para renderizar um vídeo usando AWS Lambda
# Execute este script após fazer o deploy

set -e

echo "🎬 Renderizando vídeo de exemplo usando AWS Lambda..."
echo ""

COMPOSITION="HelloWorld"
OUTPUT_FILE="output-$(date +%Y%m%d-%H%M%S).mp4"
REGION="us-east-1"

echo "📹 Composição: $COMPOSITION"
echo "💾 Arquivo de saída: $OUTPUT_FILE"
echo "🌎 Região: $REGION"
echo ""

# Renderizar vídeo
npx remotion lambda render \
  "$COMPOSITION" \
  "$OUTPUT_FILE" \
  --region "$REGION" \
  --codec h264 \
  --log verbose

echo ""
echo "✅ Renderização concluída!"
echo "📁 Vídeo salvo em: $OUTPUT_FILE"
echo ""
