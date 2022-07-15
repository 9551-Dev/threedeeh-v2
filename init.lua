local selfDir = fs.getDir(select(2,...) or "")
local old_path = package.path
package.path = string.format(
    "%s;/%s/?.lua;/%s/?/init.lua",
    package.path, selfDir,selfDir
)
local threedeeh = require "main"
return threedeeh(old_path,selfDir)