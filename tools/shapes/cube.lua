local function createCube(scale)
    local side = scale/2
    return {
        shape = {
            points={
                -side,-side,-side,
                side,-side,-side,
                -side,side,-side,
                side,side,-side,
                -side,-side,side,
                side,-side,side,
                -side,side,side,
                side,side,side
            },
            lines={
                1,2,
                2,4,
                4,3,
                3,1,
                1,5,
                2,6,
                4,8,
                3,7,
                5,6,
                6,8,
                8,7,
                7,5
            },
            triangles={
                1,3,2, 3,4,2,
                2,4,6, 4,8,6,
                3,7,4, 4,7,8,
                5,6,8, 5,8,7,
                1,5,3, 3,5,7,
                1,2,5, 2,6,5,
                cull_flags={}
            },
            textured_triangles={

            }
        },
    }
end

return {
    create_cube = createCube
}