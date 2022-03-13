local function drawFlatTopTriangle( termObj,vec1,vec2,vec3,color )
    local m1 = (vec3.x - vec1.x) / (vec3.y - vec1.y)
    local m2 = (vec3.x - vec2.x) / (vec3.y - vec2.y)
    local yStart = math.ceil(vec1.y - 0.5)
    local yEnd =   math.ceil(vec3.y - 0.5)-1
    for y = yStart, yEnd do
        local px1 = m1 * (y + 0.5 - vec1.y) + vec1.x
        local px2 = m2 * (y + 0.5 - vec2.y) + vec2.x
        local xStart = math.ceil(px1 - 0.5)
        local xEnd =   math.ceil(px2 - 0.5)
        termObj.setCursorPos(xStart,y)
        termObj.setBackgroundColor(color)
        termObj.write((" "):rep(xEnd-xStart))
    end
end

local function drawFlatBottomTriangle( termObj,vec1,vec2,vec3,color )
    local m1 = (vec2.x - vec1.x) / (vec2.y - vec1.y)
    local m2 = (vec3.x - vec1.x) / (vec3.y - vec1.y)
    local yStart = math.ceil(vec1.y-0.5)
    local yEnd =   math.ceil(vec3.y-0.5)-1
    for y = yStart, yEnd do
        local px1 = m1 * (y + 0.5 - vec1.y) + vec1.x
        local px2 = m2 * (y + 0.5 - vec1.y) + vec1.x
        local xStart = math.ceil(px1 - 0.5)
        local xEnd =   math.ceil(px2 - 0.5)
        termObj.setBackgroundColor(color)
        termObj.setCursorPos(xStart,y)
        termObj.write((" "):rep(xEnd-xStart))
    end
end
local function create( termObj,v1,v2,v3,color)
    local pv1 = vector.new(unpack(v1))
    local pv2 = vector.new(unpack(v2))
    local pv3 = vector.new(unpack(v3))
    if pv2.y < pv1.y then pv1,pv2 = pv2,pv1 end
    if pv3.y < pv2.y then pv2,pv3 = pv3,pv2 end
    if pv2.y < pv1.y then pv1,pv2 = pv2,pv1 end
    if pv1.y == pv2.y then
        if pv2.x < pv1.x then pv1,pv2 = pv2,pv1 end
        drawFlatTopTriangle(termObj,pv1,pv2,pv3,color )
    elseif pv2.y == pv3.y then
        if pv3.x < pv2.x then pv3,pv2 = pv2,pv3 end
        drawFlatBottomTriangle(termObj,pv1,pv2,pv3,color )
    else 
        local alphaSplit = (pv2.y-pv1.y)/(pv3.y-pv1.y)
        local vi ={ 
            x = pv1.x + ((pv3.x - pv1.x) * alphaSplit),      
            y = pv1.y + ((pv3.y - pv1.y) * alphaSplit), }
        if pv2.x < vi.x then
            drawFlatBottomTriangle(termObj,pv1,pv2,vi,color)
            drawFlatTopTriangle(termObj,pv2,vi,pv3,color)
        else
            drawFlatBottomTriangle(termObj,pv1,vi,pv2,color)
            drawFlatTopTriangle(termObj,vi,pv2,pv3,color)
        end
    end
end

return {
    create=create
}