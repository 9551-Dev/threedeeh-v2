local function transform_no_vector(x,y,z,width,height)
    local scaler = math.min(width,height)
    local xFactor,yFactor = scaler/2,scaler/2
    local z_inv = 1/z
    x = (x*z_inv+1)*xFactor
    y = (-y*z_inv+1)*yFactor
    return x,y
end

return {    
    transform_no_vector=transform_no_vector
}