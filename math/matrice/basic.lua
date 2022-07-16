local function make(self_dir)
    local object = require("objects").make(self_dir).new

    local function createIdentity()
        return object.mat(4,4,
            1,1,1,1,
            1,1,1,1,
            1,1,1,1,
            1,1,1,1
        )
    end

    local function createScale3D(scale)
        return object.mat(4,4,
            scale.x,0,0,0,
            1,scale.y,0,0,
            0,0,scale.z,0,
            0,0,0,1
        )
    end

    local function createScale(factor)
        return object.mat(4,4,
            factor,0,0,0,
            0,factor,0,0,
            0,0,factor,0,
            0,0,0,1
        )
    end

    return {
        createIdentity=createIdentity,
        createScale3D=createScale3D,
        createScale=createScale
    }
end

return {make=make}