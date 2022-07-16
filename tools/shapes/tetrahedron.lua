return function()
    return function(scale)
        local side = scale/2
        return {
            shape = {
                vertices={
                    -side,-side,-side,
                    side,-side,-side,
                    0,-side,side,
                    0,side,0
                },
                line_indices={
                    1,2,
                    2,3,
                    1,4,
                    2,4,
                    3,4
                },
                triangle_indices={
                    1,2,3,
                    4,2,1,
                    4,3,2,
                    4,1,3,
                    cull_flags={}
                },
                textured_triangles={
                }
            },
        }
    end
end