local function make(self_dir)
    local files = fs.list(self_dir.."/objects/")
    local objects = {new={}}
    for k,v in pairs(files) do
        if not (v == "init.lua") then
            local path = fs.combine(fs.combine(self_dir,"objects"), v)
            local data = require(path:gsub("%.lua$",""))
            if data.new then
                objects.new[v:gsub("%.lua$","")] = data.new
            end
        end
    end
    return objects
end

return {make=make}