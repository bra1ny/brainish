print_error = (err) ->
  process.stderr.write(err + "\n")


illusions = []


get_var = (illusion_id, var_name) ->
  illusion_id + "__" + var_name


process_input = (input_list) ->
  for input_name, input_value of input_list
    if input_value[0] == "#"
      input_value_pieces = input_value.substring(1).split(".")
      input_value = "${" + get_var(input_value_pieces[0], input_value_pieces[1]) + "}"
    input_list[input_name] = input_value
  input_list


process_bash = (id, input, sub, bash) ->

  while (start = bash.indexOf("_var(")) >= 0
    end = bash.indexOf(")", start)
    old_name = bash.substring(start+5, end)
    bash = bash.substring(0, start) + get_var(id, old_name) + bash.substring(end+1)

  while (start = bash.indexOf("_input(")) >= 0
    end = bash.indexOf(")", start)
    old_name = bash.substring(start+7, end)
    bash = bash.substring(0, start) + input[old_name] + bash.substring(end+1)

  while (start = bash.indexOf("_sub(")) >= 0
    end = bash.indexOf(")", start)
    sub_name = bash.substring(start+5, end)
    indent = 0
    indent_space = ""
    while bash.charAt(start - indent - 1) == " "
      indent++
      indent_space += " "
    sub_janish = j2b(sub[sub_name])
    indented_janish = ""
    for line in sub_janish.trim().split("\n")
      indented_janish += indent_space + line + "\n"
    bash = bash.substring(0, start - indent) + indented_janish + bash.substring(end+1)

  bash


exports.j2b = j2b = (janish) ->
  output = ""
  if Array.isArray(janish)
    for j in janish
      output += j2b(j)
  else
    output += "# Illusion " + janish["id"] + "(" + janish["illusion"] + ") begins\n"
    illusion = illusions[janish["illusion"]]
    if illusion
      id = janish["id"]
      input = process_input(janish["input"])
      sub = janish["sub"]
      bash = illusion["bash"]
      output += process_bash(id, input, sub, bash)
    else
      output = "NOT_IMPLEMENT\n"
    output += "# Illusion " + janish["id"] + "(" + janish["illusion"] + ") ends\n"
  output


compile_janish = (janish) ->
  illusions = janish["illusion"]
  code = janish["janish"]
  "#!/usr/bin/env bash\n" + j2b(code)


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
      print_error "Error during compilation:"
      print_error err.message