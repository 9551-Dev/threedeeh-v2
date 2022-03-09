local function matrix_multiply(a, b)
    if a.matrix_width ~= b.matrix_height then error("invalid matrix sizes", 2) end
    local m = {}
    m.matrix_height = a.matrix_height
    m.matrix_width = b.matrix_width
    for y=0,a.matrix_height-1 do
        for x=0,b.matrix_width-1 do
            local sum = 0
            for i=0,a.matrix_width-1 do
                sum = sum + a[y*a.matrix_width+i+1]*b[i*b.matrix_width+x+1]
            end
            m[y*b.matrix_width+x+1] = sum
        end
    end
    return m
end

local function attacher(self,matrice)
    return setmetatable(matrix_multiply(self,matrice),{
        __mul=attacher,
    })
end

local function matrix(N, M, ...)
    local m = { ... }
    m.matrix_width = N
    m.matrix_height = M
    return setmetatable(m,{__mul = attacher})
end

local function vector(...)
    local m = { ... }
    return matrix(#m, 1, ...)
end

return {
    create=matrix,
    matrix_multiply,
}