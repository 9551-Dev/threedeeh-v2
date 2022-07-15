local matrice = require("math.matrices.matrice_object")
local SIN = math.sin
local COS = math.cos

local function create_rotation_z(theta)
    local sinTheta = SIN(theta)
    local cosTheta = COS(theta)
    return matrice.create(3,3,
        cosTheta,sinTheta,0,
        -sinTheta,cosTheta,0,
        0,0,1
    )
end

local function create_rotation_y(theta)
    local sinTheta = SIN(theta)
    local cosTheta = COS(theta)
    return matrice.create(3,3,
        cosTheta,0,-sinTheta,
        0,1,0,
        sinTheta,0,cosTheta
    )
end

local function create_rotation_x(theta) 
    local sinTheta = SIN(theta)
    local cosTheta = COS(theta)
    return matrice.create(3,3,
        1,0,0,
        0,cosTheta,sinTheta,
        0,-sinTheta,cosTheta
    )
end

return {
    create_rotation_x=create_rotation_x,
    create_rotation_y=create_rotation_y,
    create_rotation_z=create_rotation_z
}