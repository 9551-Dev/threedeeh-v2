local function swap(a,b)
    return b,a
end

local function draw_flat_top_triangle(v0,v1,v2,c)
    local m0 = (v2.x-v0.x)/(v2.y-v0.y)
    local m1 = (v2.x-v1.x)/(v2.y-v1.y)

    local yStart = math.ceil(v0.y-0.5)
    local yEnd = math.ceil(v2.y-0.5)

    for y=yStart,yEnd do
        local px0 = m0*(y+0.5-v0.y)+v0.x
        local px1 = m1*(y+0.5-v1.y)+v1.x

        local xStart = math.ceil(px0-0.5)
        local xEnd = math.ceil(px1-0.5)

        term.setCursorPos(xStart,y)
        local cNow = term.getBackgroundColor()
        term.setBackgroundColor(c)
        term.write((" "):rep(xEnd-xStart))
        term.setBackgroundColor(cNow)
    end
end

local function draw_flat_bottom_triangle(v0,v1,v2,c)
    local m0 = (v1.x-v0.x)/(v1.y-v0.y)
    local m1 = (v2.x-v0.x)/(v2.y-v0.y)

    local yStart = math.ceil(v0.y-0.5)
    local yEnd = math.ceil(v2.y-0.5)

    for y=yStart,yEnd do
        local px0 = m0*(y+0.5-v0.y)+v0.x
        local px1 = m1*(y+0.5-v0.y)+v0.x

        local xStart = math.ceil(px0-0.5)
        local xEnd = math.ceil(px1-0.5)

        term.setCursorPos(xStart,y)
        local cNow = term.getBackgroundColor()
        term.setBackgroundColor(c)
        term.write((" "):rep(xEnd-xStart))
        term.setBackgroundColor(cNow)
    end
end


local function drawTriangle(v1,v2,v3,color)
    local pv0 = vector.new(unpack(v1))
    local pv1 = vector.new(unpack(v2))
    local pv2 = vector.new(unpack(v3))

    if pv1.y < pv0.y then local pv0,pv1 = swap(pv0,pv1) end
    if pv2.y < pv1.y then local pv1,pv2 = swap(pv1,pv2) end
    if pv1.y < pv0.y then local pv0,pv1 = swap(pv0,pv1) end

    if pv0.y == pv1.y then
        if pv1.x < pv0.x then pv0,pv1 = swap(pv0,pv1) end
        draw_flat_top_triangle(pv0,pv1,pv2,color)
    elseif pv1.y == pv2.y then
        if pv2.x < pv1.x then pv1,pv2 = swap(pv1,pv2) end
        draw_flat_bottom_triangle(pv0,pv1,pv2,color)
    else
        local alpha_split = (pv1.y-pv0.y)/(pv2.y-pv0.y)
        local vi = pv0+(pv2-pv0)*alpha_split
        if pv1.x < vi.x then
            draw_flat_bottom_triangle(pv0,pv1,vi,color)
            draw_flat_top_triangle(pv1,vi,v2,color)
        else
            draw_flat_bottom_triangle(pv0,vi,pv1,color)
            draw_flat_top_triangle(vi,pv1,pv2,color)
        end
    end
end

return {
    create = drawTriangle
}