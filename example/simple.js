const alpr = require('../dist')
const path = require('path')
const opts = {
  json: true,
  country: 'us',
  topn: 6

}

alpr(path.join(__dirname, './lp.jpg'), opts)
  .then((r) => console.log('result', r))
  .catch((e) => console.log('error', e))
