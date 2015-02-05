compile = require("../brainish").j2b
helper = require("../helper")

module.exports = (janish) ->
  var_file_list = helper.variable(janish["id"], "file_list")
  var_file_list + "=$(ls " + janish["input"]["path"] + ")\n"