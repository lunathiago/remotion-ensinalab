#!/usr/bin/env node

/**
 * Script para fazer deploy do Remotion na AWS Lambda
 * 
 * Pré-requisitos:
 * 1. Ter as credenciais AWS configuradas (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
 * 2. Ter feito o build do projeto com: npm run build
 * 
 * Para executar: node deploy-lambda.mjs
 */

import {
  deployFunction,
  deploySite,
  getRegions,
} from '@remotion/lambda';
import { readFileSync } from 'fs';
import { join } from 'path';

const REGION = 'us-east-1';
const BUCKET_NAME = 'remotion-render-ensinalab';

async function deploy() {
  try {
    console.log('🚀 Iniciando deploy do Remotion na AWS Lambda...\n');

    // 1. Verificar se o bucket existe
    console.log(`📦 Usando bucket: ${BUCKET_NAME}`);
    console.log(`🌎 Região: ${REGION}\n`);

    // 2. Deploy da função Lambda
    console.log('⚡ Fazendo deploy da função Lambda...');
    const functionInfo = await deployFunction({
      createCloudWatchLogGroup: true,
      memorySizeInMb: 2048,
      timeoutInSeconds: 120,
      region: REGION,
      architecture: 'arm64', // arm64 é mais barato e eficiente
    });

    console.log('✅ Função Lambda criada com sucesso!');
    console.log(`   Nome: ${functionInfo.functionName}`);
    console.log(`   ARN: ${functionInfo.functionArn}`);
    console.log(`   Versão: ${functionInfo.version}\n`);

    // 3. Deploy do site (bundle do Remotion)
    console.log('🌐 Fazendo deploy do site...');
    const siteInfo = await deploySite({
      bucketName: BUCKET_NAME,
      entryPoint: join(process.cwd(), 'src', 'index.ts'),
      region: REGION,
      siteName: 'remotion-ensinalab',
    });

    console.log('✅ Site criado com sucesso!');
    console.log(`   ID do Site: ${siteInfo.serveUrl}`);
    console.log(`   Bucket: ${siteInfo.bucketName}\n`);

    console.log('🎉 Deploy concluído com sucesso!\n');
    console.log('📝 Informações importantes:');
    console.log(`   - Nome da função: ${functionInfo.functionName}`);
    console.log(`   - URL do site: ${siteInfo.serveUrl}`);
    console.log(`   - Região: ${REGION}\n`);

    console.log('Para renderizar um vídeo, use:');
    console.log('npx remotion lambda render <composition-id> output.mp4\n');

  } catch (error) {
    console.error('❌ Erro durante o deploy:', error);
    process.exit(1);
  }
}

deploy();
