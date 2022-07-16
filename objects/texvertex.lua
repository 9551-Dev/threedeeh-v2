local ilib = require("math.interpolation")

local function texvertex(pos,tc)
    local tvertex = {pos=pos,tc=tc}
    return setmetatable(tvertex,{__index = {
        interpolate_to=function(destination,alpha)
            return texvertex(
                ilib.interpolate_to(tvertex.pos,destination.pos,alpha),
                ilib.interpolate_to(tvertex.tc,destination.tc,alpha)
            )
        end
    }})
end

return {
    new=texvertex
}