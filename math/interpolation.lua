local function interpolate_to(vector1, vector2, alpha)
    return vector1 + (vector2 - vector1) * alpha
end

local function interpolate(p1,p2,y)
    return (((y-p1.y)*(p2.x-p1.x)) / (p2.y-p1.y) + p1.x)
end
local function interpolateY(a,b,y)
    local ya = y - a.y
    local ba = b.y - a.y
    local x = a.x + (ya * (b.x - a.x)) / ba
    local z = a.z + (ya * (b.z - a.z)) / ba
    return x,z
end
local function interpolateZ(a,b,x)
    local z = a.z + (x-a.x) * (((b.z-a.z)/(b.x-a.x)))
    return z
end
local function intY(a,b,y)
    return a.x + ((y - a.y) * (b.x - a.x)) / (b.y - a.y)
end
local function getT(a,b,p)
    local v1 = vector.new( a.x-b.x, a.y-b.y )
    local v2 = vector.new( a.x-p.x, a.y-p.y )
    return (v1:dot(v2)) / (v1:dot(v1))
end
local function lerp(v1,v2,t)
    return (1 - t) * v1 + t * v2
end
local function interpolateOnLine(x1, y1, w1, x2, y2, w2, x3, y3)
    local fxy1=(x2-x3)/(x2-x1)*w1+(x3-x1)/(x2-x1)*w2
    return (y2-y3)/(y2-y1)*fxy1+(y3-y1)/(y2-y1)*fxy1
end

return {
    interpolate_to    = interpolate_to,
    interpolate       = interpolate,
    interpolateY      = interpolateY,
    interpolateZ      = interpolateZ,
    intY              = intY,
    getT              = getT,
    lerp              = lerp,
    interpolateOnLine = interpolateOnLine
}