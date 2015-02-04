error = (err) ->
  process.stderr.write(err + "\n")


compile = (janish) ->
  bash = "# Janish begins: " + janish["id"] + " (" + janish["type"] + ")\n"
  try
    illusion = require "./illusions/" + janish["type"]
    bash += illusion(janish)
  catch err
    if err.code == "MODULE_NOT_FOUND"
      bash += "INVALID_ILLUSION\n"
    else
      console.log err.stack
      throw Error(err.message)
  bash += "# Janish ends: " + janish["id"] + "\n"
  bash


exports.compile = compile


exports.run = () ->
  stdin = process.stdin
  stdout = process.stdout
  inputChunks = []

  stdin.resume()
  stdin.setEncoding('utf8')

  stdin.on 'data', (chunk) =>
    inputChunks.push chunk

  stdin.on 'end', =>
    inputJson = inputChunks.join()
    janish = JSON.parse(inputJson)
    try
      outputBash = compile(janish)
      stdout.write(outputBash)
    catch err
      error "Error during compilation:"
      error err.message