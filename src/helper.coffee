exports.variable = (janish_name, name) ->
  janish_name + "__" + name

exports.indent = (lines) ->
  output = ""
  for line in lines.trim().split("\n")
    output += "    " + line + "\n"
  output