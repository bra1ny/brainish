compile = (janish) ->
  bash = ""
  switch janish["type"]
    when "group"
      bash += "group\n"
    else
      bash += "NOT IMPLEMENTED YET\n"
  return bash

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
    outputBash = compile(janish)
    stdout.write(outputBash)
