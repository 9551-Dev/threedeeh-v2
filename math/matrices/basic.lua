local matrice = require("matrice_object")

local function createIdentity()
    return matrice.create(4,4,
        1,1,1,1,
        1,1,1,1,
        1,1,1,1,
        1,1,1,1
    )
end

local function createScale3D(scale)
    return matrice.create(4,4,
        scale.x,0,0,0,
        1,scale.y,0,0,
        0,0,scale.z,0,
        0,0,0,1
    )
end

local function createScale(factor)
    return matrice.create(4,4,
        factor,0,0,0,
        0,factor,0,0,
        0,0,factor,0,
        0,0,0,1
    )
end