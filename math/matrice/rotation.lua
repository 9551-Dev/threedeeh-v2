local function make(self_dir)
    local object = require("objects").make(self_dir).new
    local SIN = math.sin
    local COS = math.cos
    local RAD = math.rad

    local function create_rotation_z(theta)
        local sinTheta = SIN(theta)
        local cosTheta = COS(theta)
        return object.mat(3,3,
            cosTheta,sinTheta,0,
            -sinTheta,cosTheta,0,
            0,0,1
        )
    end

    local function create_rotation_y(theta)
        local sinTheta = SIN(theta)
        local cosTheta = COS(theta)
        return object.mat(3,3,
            cosTheta,0,-sinTheta,
            0,1,0,
            sinTheta,0,cosTheta
        )
    end

    local function create_rotation_x(theta) 
        local sinTheta = SIN(theta)
        local cosTheta = COS(theta)
        return object.mat(3,3,
            1,0,0,
            0,cosTheta,sinTheta,
            0,-sinTheta,cosTheta
        )
    end

    local function create_rotation_eulers(eulers)
        local x = RAD(eulers.x)
        local y = RAD(eulers.y)
        local z = RAD(eulers.z)
        local sx = SIN(x)
        local sy = SIN(y)
        local sz = SIN(z)
        
        local cx = COS(x)
        local cy = COS(y)
        local cz = COS(z)

        return object.mat(4,4,
            cy*cz,-cy*sz,sy,0,
            (sx*sy*cz) +(cx*sz), (-sx*sy*sz)+(cx*cz),-sx*cy,0,
            (-cx*sy*cz)+(sx*sz), (cx*sy*sz) +(sx*cz),cx*cy,0,
            0,0,0,1
        )
    end

    return {
        create_rotation_x=create_rotation_x,
        create_rotation_y=create_rotation_y,
        create_rotation_z=create_rotation_z,
        create_rotation_eulers=create_rotation_eulers
    }
end

return {make=make}