const alpr = require('../dist')
const path = require('path')

alpr(path.join(__dirname, './lp.jpg'))
  .then((r) => console.log('result', r))
  .catch((e) => console.log('error', e))
