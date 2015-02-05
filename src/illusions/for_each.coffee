j2b = require("../brainish").j2b
helper = require("../helper")

module.exports = (janish) ->
  var_iterator = helper.variable(janish["id"], "iterator")
  bash = ""
  bash += "for " + var_iterator + " in " + janish["input"]["list"] + "; do\n"
  bash += helper.indent(j2b(janish["submodule"]["loop_body"]))
  bash += "done\n"
  bash