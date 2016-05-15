{ reduce, toPairs, pick } = require 'ramda'
spawn = require('child_process').spawn
path = require 'path'
nth = (i, list) => list[i]
VALID_ARGS = [ 'country', 'topn', 'seek', 'pattern', 'motion', 'clock', 'detect_region', 'json' ]
DEFAULT_OPTIONS =
    json: true
    country: 'eu'

concatArg = (args, [key, value]) =>
  if typeof value == 'boolean'
    if value then [args..., "--#{key}"] else args
  else
    [args..., "--#{key}", value]

runAlpr = (file, options) =>
  args = reduce concatArg, [], toPairs options
  console.log 'ARGS', args
  spawn 'alpr', [args..., file]

module.exports = (file, _options) =>
  options = pick VALID_ARGS, (Object.assign {}, DEFAULT_OPTIONS, _options)
  proc = runAlpr file, options
  data = ''
  err = ''

  result = new Promise (resolve, reject) =>
    proc.stdout.on 'data', (d) => data += d
    proc.stderr.on 'data', (d) => err += d
    proc.on 'close', (code) =>
      if code == 0 then resolve data else reject err

  result
    .then (d) =>
      if options.json then JSON.parse d else d
