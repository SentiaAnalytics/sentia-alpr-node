spawn = require('child_process').spawn
path = require 'path'
nth = (i, list) => list[i]

module.exports = (file) =>
  proc = spawn 'alpr', ['-j', file]
  data = ''
  err = ''

  proc.stdout.on 'data', (d) => data += d
  proc.stderr.on 'data', (d) => err += d

  result = new Promise (resolve, reject) =>
    proc.on 'close', (code) =>
      if code == 0 then resolve data else reject err

  result
    .then JSON.parse
