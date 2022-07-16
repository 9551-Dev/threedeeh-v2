local function createColor(whitelist,blacklist)
    local cols,clist,cCount = {},{},0
    local acls = whitelist or {}
    local skipWhite = (not whitelist)
    local skipBlack = (not blacklist)
    local useall = (not whitelist and not blacklist)
    local bcls = blacklist or {}
    local clist = {}
    for k,v in pairs(colors) do
        if type(v) == "number" then
            if useall then
                table.insert(clist,v)
            else
                if skipBlack and whitelist and acls then if acls[v] then table.insert(clist,v) end
                else if acls[v] and not bcls[v] then table.insert(clist,v) end end
                if skipWhite and blacklist then if not bcls[v] then table.insert(clist,v) end
                else if acls[v] and not bcls[v] then table.insert(clist,v) end end
            end
        end 
    end
    return setmetatable({},{
        __index=function(t,k)
            cCount = cCount + 1
            local col = clist[cCount]
            if cCount >= #clist then cCount = 0 end
            t[k]=col
            return col
        end
    })
end

return {
    create=createColor
}