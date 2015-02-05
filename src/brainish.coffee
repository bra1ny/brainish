error = (err) ->
  process.stderr.write(err + "\n")


j2b = (janish) ->
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


exports.j2b = j2b


compile_janish = (janish) ->
  j2b(janish)


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
      outputBash = compile_janish(janish)
      stdout.write(outputBash)
    catch err
      error "Error during compilation:"
      error err.message