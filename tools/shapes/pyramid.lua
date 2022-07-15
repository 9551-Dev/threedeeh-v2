return function(scale)
    local side = scale/2
    return {
        shape = {
            points={
                -side,-side,-side,
                side,-side,-side,
                side,-side,side,
                -side,-side,side,
                0,side,0
            },
            lines={
                1,2,
                1,4,
                4,3,
                3,2,
                1,5,
                2,5,
                3,5,
                4,5
            },
            triangles={
                1,2,3,
                5,2,1,
                5,3,2,
                5,4,3,
                5,1,4,
                4,1,3,
                cull_flags={}
            },
            textured_triangles={
            }
        },
    }
end