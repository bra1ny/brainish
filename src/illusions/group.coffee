compile = require("../brainish").compile

module.exports = (janish) ->
  bash = ""
  for submodule in janish["submodule"]
    bash += compile(submodule)
  bash