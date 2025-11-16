// FORMATO NOVO - CORRETO
import {defineConfig} from 'remotion';

export default defineConfig({
  // O nome do seu bucket S3 será gerado a partir disso
  // ex: remotion-render-my-video-xxxx
  s3Bucket: 'remotion-render-ensinalab', // <- Troque para um nome único se quiser
  
  // A região da AWS para fazer o deploy.
  // Precisa ser a mesma que você usou no bootstrap!
  lambdaRegion: 'us-east-1',

  // Opcional: outras configurações que você pode querer
  // ...
});