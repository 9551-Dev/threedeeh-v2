local function make(self_dir)
    local files = fs.list(self_dir.."/tools/shapes/")
    local shapes = {new={}}
    for k,v in pairs(files) do
        if not (v == "init.lua") then
            local path = fs.combine(fs.combine(self_dir,"tools/shapes/"), v)
            local data = require(path:gsub("%.lua$",""))
            shapes.new[v:gsub("%.lua$","")] = data(self_dir)
        end
    end
    return shapes
end

return {make=make}