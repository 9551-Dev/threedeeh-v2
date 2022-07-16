local function get_textured_triangle_points(vertex0,vertex1,vertex2,texture)
    local points = {list={},LUT={}}
    if vertex1.y < vertex0.y then vertex0,vertex1 = vertex1,vertex0 end
    if vertex2.y < vertex1.y then vertex1,vertex2 = vertex2,vertex1 end
    if vertex1.y < vertex0.y then vertex0,vertex1 = vertex1,vertex0 end
end