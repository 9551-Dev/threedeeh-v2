local matrice = require("math.matrices.matrice_object")

local function create_rotation_z(theta)
    local sinTheta = math.sin(theta)
    local cosTheta = math.cos(theta)
    return matrice.create(3,3,
        cosTheta,sinTheta,0,
        -sinTheta,cosTheta,0,
        0,0,1
    )
end

local function create_rotation_y(theta)
    local sinTheta = math.sin(theta)
    local cosTheta = math.cos(theta)
    return matrice.create(3,3,
        cosTheta,0,-sinTheta,
        0,1,0,
        sinTheta,0,cosTheta
    )
end

local function create_rotation_x(theta) 
    local sinTheta = math.sin(theta)
    local cosTheta = math.cos(theta)
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