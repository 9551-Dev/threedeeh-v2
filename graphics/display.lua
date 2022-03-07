local function transform(v,width,height)
    local xFactor,yFactor = width/2,height/2
    v.x = (v.x+1)*xFactor
    v.y = (v.y+1)*yFactor
    return v
end

return {
    transform = transform,
}