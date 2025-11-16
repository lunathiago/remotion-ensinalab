const {defineConfig} = require('remotion');

module.exports = defineConfig({
  s3Bucket: 'remotion-render-ensinalab',
  lambdaRegion: 'us-east-1',
});