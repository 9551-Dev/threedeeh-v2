return function(self_dir)
    return function(scale)
        local side = scale/2
        return {
            shape = {
                vertices={
                    -side,0,-side,
                    side,0,-side,
                    0,0,side
                },
                line_indices={
                    1,2,
                    2,3,
                    3,1
                },
                triangle_indices={
                    3,2,1,
                    cull_flags={}
                },
                UV={

                }
            },
        }
    end
end