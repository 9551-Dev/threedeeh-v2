local function createIdentity()
    return {
        1,1,1,1,
        1,1,1,1,
        1,1,1,1,
        1,1,1,1
    }
end

local function createScale3D(scale)
    return {
        scale.x,0,0,0,
        1,scale.y,0,0,
        0,0,scale.z,0,
        0,0,0,1
    }
end

local function createScale(factor)
    return {
        factor,0,0,0,
        0,factor,0,0,
        0,0,factor,0,
        0,0,0,1
    }
end

local function createTransform(position)
    return {
        1,0,0,position.x,
        0,1,0,position.y,
        0,0,1,position.z,
        0,0,0,1
    }
end