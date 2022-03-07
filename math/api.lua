local numberToType = {"x","y","z"}

local function matmul4(m1,m2)
    return {
        m1[1]*m2[1]+m1[2]*m2[5]+m1[3]*m2[9]+m1[4]*m2[13],
        m1[1]*m2[2]+m1[2]*m2[6]+m1[3]*m2[10]+m1[4]*m2[14],
        m1[1]*m2[3]+m1[2]*m2[7]+m1[3]*m2[11]+m1[4]*m2[15],
        m1[1]*m2[4]+m1[2]*m2[8]+m1[3]*m2[12]+m1[4]*m2[16],
        m1[5]*m2[1]+m1[6]*m2[5]+m1[7]*m2[9]+m1[8]*m2[13],
        m1[5]*m2[2]+m1[6]*m2[6]+m1[7]*m2[10]+m1[8]*m2[14],
        m1[5]*m2[3]+m1[6]*m2[7]+m1[7]*m2[11]+m1[8]*m2[15],
        m1[5]*m2[4]+m1[6]*m2[8]+m1[7]*m2[12]+m1[8]*m2[16],
        m1[9]*m2[1]+m1[10]*m2[5]+m1[11]*m2[9]+m1[12]*m2[13],
        m1[9]*m2[2]+m1[10]*m2[6]+m1[11]*m2[10]+m1[12]*m2[14],
        m1[9]*m2[3]+m1[10]*m2[7]+m1[11]*m2[11]+m1[12]*m2[15],
        m1[9]*m2[4]+m1[10]*m2[8]+m1[11]*m2[12]+m1[12]*m2[16],
        m1[13]*m2[1]+m1[14]*m2[5]+m1[15]*m2[9]+m1[16]*m2[13], 
        m1[13]*m2[2]+m1[14]*m2[6]+m1[15]*m2[10]+m1[16]*m2[14], 
        m1[13]*m2[3]+m1[14]*m2[7]+m1[15]*m2[11]+m1[16]*m2[15], 
        m1[13]*m2[4]+m1[14]*m2[8]+m1[15]*m2[12]+m1[16]*m2[16]
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


return {
    matmul4=matmul4,
    vectorByMatrixMul3,
    vectorByMatrixMul4,
}