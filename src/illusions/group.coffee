j2b = require("../brainish").j2b

module.exports = (janish) ->
  bash = ""
  for submodule in janish["submodule"]
    bash += j2b(submodule)
  bash