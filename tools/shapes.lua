local function createCube(scale)
    local side = scale/2
    return {
        shape = {
            points={
                -side,-side,-side,side,-side,-side,-side,side,-side,side,side,-side,-side,-side,side,side,-side,side,-side,side,side,side,side,side
            },
            lines= {
                1,2,2,4,4,3,3,1,1,5,2,6,4,8,3,7,5,6,6,8,8,7,7,5
            }
        }
    }
end