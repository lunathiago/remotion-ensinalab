// remotion.config.ts
import {defineConfig} from 'remotion';

export default defineConfig({
  // O nome do seu bucket S3 será gerado a partir disso
  s3Bucket: 'remotion-render-ensinalab',
  
  // A região da AWS para fazer o deploy.
  lambdaRegion: 'us-east-1',
});