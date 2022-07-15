local function draw_flat_top_triangle(v0,v1,v2,points,caller)
    local m0 = (v2.x - v0.x) / (v2.y - v0.y)
    local m1 = (v2.x - v1.x) / (v2.y - v1.y)
    local y_start = math.ceil(v0.y - 0.5)
    local y_end   = math.ceil(v2.y - 0.5) - 1
    for y=y_start,y_end do 
        local px0 = m0 * (y + 0.5 - v0.y) + v0.x
        local px1 = m1 * (y + 0.5 - v1.y) + v1.x
        local x_start = math.ceil(px0 - 0.5)
        local x_end   = math.ceil(px1 - 0.5)
        for x=x_start,x_end do
            points.list[#points.list+1] =  {x=x,y=y}
            if not points.LUT[y] then points.LUT[y] = {} end
            points.LUT[y][x] = true
            if caller then caller(x,y) end
        end
    end
end

local function draw_flat_bottom_triangle(v0,v1,v2,points,caller)
    local m0 = (v1.x - v0.x) / (v1.y - v0.y)
    local m1 = (v2.x - v0.x) / (v2.y - v0.y)
    local y_start = math.ceil(v0.y - 0.5)
    local y_end   = math.ceil(v2.y - 0.5) - 1
    for y=y_start,y_end do 
        local px0 = m0 * (y + 0.5 - v0.y) + v0.x
        local px1 = m1 * (y + 0.5 - v0.y) + v0.x
        local x_start = math.ceil(px0 - 0.5)
        local x_end   = math.ceil(px1 - 0.5)
        for x=x_start,x_end do
            points.list[#points.list+1] =  {x=x,y=y}
            if not points.LUT[y] then points.LUT[y] = {} end
            points.LUT[y][x] = true
            if caller then caller(x,y) end
        end
    end
end

local function get_triangle_points(vector0,vector1,vector2,caller)
    local points = {list={},LUT={}}
    if vector1.y < vector0.y then vector0,vector1 = vector1,vector0 end
    if vector2.y < vector1.y then vector1,vector2 = vector2,vector1 end
    if vector1.y < vector0.y then vector0,vector1 = vector1,vector0 end
    if vector0.y == vector1.y then
        if vector1.x < vector0.x then vector0,vector1 = vector1,vector0 end
        draw_flat_top_triangle(vector0,vector1,vector2,points,caller)
    elseif vector1.y == vector2.y then
        if vector2.x < vector1.x then vector1,vector2 = vector2,vector1 end
        draw_flat_bottom_triangle(vector0,vector1,vector2,points,caller)
    else
        local alpha_split = (vector1.y-vector0.y) / (vector2.y-vector0.y)
        local split_vertex = { 
            x = vector0.x + ((vector2.x - vector0.x) * alpha_split),      
            y = vector0.y + ((vector2.y - vector0.y) * alpha_split),
        }
        if vector1.x < split_vertex.x then
            draw_flat_bottom_triangle(vector0,vector1,split_vertex,points,caller)
            draw_flat_top_triangle   (vector1,split_vertex,vector2,points,caller)
        else
            draw_flat_bottom_triangle(vector0,split_vertex,vector1,points,caller)
            draw_flat_top_triangle   (split_vertex,vector1,vector2,points,caller)
        end
    end
    return points.list
end

return {
    create=get_triangle_points
}