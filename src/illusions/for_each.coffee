compile = require("../brainish").compile
helper = require("../helper")

module.exports = (janish) ->
  var_iterator = helper.variable(janish["id"], "iterator")
  bash = ""
  bash += "for " + var_iterator + " in " + janish["input"]["list"] + "; do\n"
  bash += helper.indent(compile(janish["submodule"]["loop_body"]))
  bash += "done\n"
  bash