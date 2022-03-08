local function transform(v,width,height)
    local xFactor,yFactor = width/2,height/2
    v.x = (v.x+1)*xFactor
    v.y = (-v.y+1)*yFactor
    return v
end

local function transform_no_vector(x,y,width,height)
    local scaler = math.min(width,height)
    local xFactor,yFactor = scaler/2,scaler/2+(10/3*2)
    x = (x+1)*xFactor
    y = (-y+1)*yFactor
    return x,y
end

return {    
    transform = transform,
    transform_no_vector=transform_no_vector
}