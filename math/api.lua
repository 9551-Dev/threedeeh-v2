local numberToType = {"x","y","z"}

local function matmul4(m1,m2)
    return {
        m1[1] *m2[1]+m1[2] *m2[5]+m1[3] *m2[9] +m1[4] *m2[13],
        m1[1] *m2[2]+m1[2] *m2[6]+m1[3] *m2[10]+m1[4] *m2[14],
        m1[1] *m2[3]+m1[2] *m2[7]+m1[3] *m2[11]+m1[4] *m2[15],
        m1[1] *m2[4]+m1[2] *m2[8]+m1[3] *m2[12]+m1[4] *m2[16],
        m1[5] *m2[1]+m1[6] *m2[5]+m1[7] *m2[9] +m1[8] *m2[13],
        m1[5] *m2[2]+m1[6] *m2[6]+m1[7] *m2[10]+m1[8] *m2[14],
        m1[5] *m2[3]+m1[6] *m2[7]+m1[7] *m2[11]+m1[8] *m2[15],
        m1[5] *m2[4]+m1[6] *m2[8]+m1[7] *m2[12]+m1[8] *m2[16],
        m1[9] *m2[1]+m1[10]*m2[5]+m1[11]*m2[9] +m1[12]*m2[13],
        m1[9] *m2[2]+m1[10]*m2[6]+m1[11]*m2[10]+m1[12]*m2[14],
        m1[9] *m2[3]+m1[10]*m2[7]+m1[11]*m2[11]+m1[12]*m2[15],
        m1[9] *m2[4]+m1[10]*m2[8]+m1[11]*m2[12]+m1[12]*m2[16],
        m1[13]*m2[1]+m1[14]*m2[5]+m1[15]*m2[9] +m1[16]*m2[13], 
        m1[13]*m2[2]+m1[14]*m2[6]+m1[15]*m2[10]+m1[16]*m2[14], 
        m1[13]*m2[3]+m1[14]*m2[7]+m1[15]*m2[11]+m1[16]*m2[15], 
        m1[13]*m2[4]+m1[14]*m2[8]+m1[15]*m2[12]+m1[16]*m2[16]
    }
end

local function matmul3(m1,m2)
    return {
        m1[1]*m2[1],m1[2]+m2[4],m1[3]+m2[7],
        m1[1]*m2[2],m1[2]+m2[5],m1[3]+m2[8],
        m1[1]*m2[3],m1[2]+m2[6],m1[3]+m2[9],
        m1[4]*m2[1],m1[5]+m2[4],m1[6]+m2[7],
        m1[4]*m2[2],m1[5]+m2[5],m1[6]+m2[8],
        m1[4]*m2[3],m1[5]+m2[6],m1[6]+m2[9],
        m1[7]*m2[1],m1[8]+m2[4],m1[9]+m2[7],
        m1[7]*m2[2],m1[8]+m2[5],m1[9]+m2[8],
        m1[7]*m2[3],m1[8]+m2[6],m1[9]+m2[9],
    }
end

local function matrix_by_vector(m,v)
    return {
        m[1]*v[1]+m[2]*v[4]+m[3]+v[7],
        m[4]*v[1]+m[5]*v[4]+m[6]+v[7],
        m[7]*v[1]+m[8]*v[4]+m[9]+v[7],
    }
end

local function vectorByMatrixMul3(mat,vec)
    return {
        vec.x*mat[1]+vec.y*mat[2]+vec.z*mat[3],
        vec.x*mat[4]+vec.y*mat[5]+vec.z*mat[6],
        vec.x*mat[7]+vec.y*mat[8]+vec.z*mat[9],
    }
end

local function vectorByMatrixMul4(mat,vec)
    return {
        vec.x*mat[1]+vec.y*mat[2]+vec.z*mat[3],vec.w*mat[4],
        vec.x*mat[5]+vec.y*mat[6]+vec.z*mat[7],vec.w*mat[8],
        vec.x*mat[9]+vec.y*mat[10]+vec.z*mat[11],vec.w*mat[12],
        vec.x*mat[13]+vec.y*mat[14]+vec.z*mat[15],vec.w*mat[16],
    }
end

local function matmul(m1, m2, width)
    local result = {}
    for i = 1, #m1,width do
    end
    return result
end

local function wrap_angle(theta)
    local modded = theta%(2*math.pi)
    return (modded > math.pi) and (modded-2*math.pi) or modded
end

return {
    matmul4=matmul4,
    matmul3=matmul3,
    matmul_any=matmul,
    vectorByMatrixMul3=vectorByMatrixMul3,
    vectorByMatrixMul4=vectorByMatrixMul4,
    wrap_angle=wrap_angle
}