local CEIL = math.ceil
local MAX  = math.max
local MIN  = math.min

local function draw_textured_flat_top_triangle(v0,v1,v2,texture,points,caller)
    local v0x,v0y,v0z = v0.pos.x,v0.pos.y,v0.pos.z
    local v1x,v1y,v1z = v1.pos.x,v1.pos.y,v1.pos.z
    local v2x,v2y,v2z = v2.pos.x,v2.pos.y,v2.pos.z
    local LIST,LUT = points.list,points.LUT
    local m0 = (v2x - v0x) / (v2y - v0y)
    local m1 = (v2x - v1x) / (v2y - v1y)
    local y_start = CEIL(v0y - 0.5)
    local y_end   = CEIL(v2y - 0.5) - 1

    local tc_edge_l  = v0.tc
    local tc_edge_r  = v1.tc
    local tc_bottom  = v2.tc

    local tc_step_l = (tc_bottom - tc_edge_l) / (v2y - v0y)
    local tc_step_r = (tc_bottom - tc_edge_r) / (v2y - v1y)

    tc_edge_l = tc_edge_l + tc_step_l * (y_start + 0.5 - v1y)
    tc_edge_r = tc_edge_r + tc_step_r * (y_start + 0.5 - v1y)

    local tex_width   = texture.width
    local tex_height  = texture.height
    local tex_clamp_x = tex_width  - 1
    local tex_clamp_y = tex_height - 1

    local n = #LIST
    for y=y_start,y_end do 
        local px0     = m0 * (y + 0.5 - v0y) + v0x
        local px1     = m1 * (y + 0.5 - v1y) + v1x
        local x_start = CEIL (px0 - 0.5)
        local x_end   = CEIL (px1 - 0.5)

        local tc_scan_step = (tc_edge_r - tc_edge_l) / (px1 - px0)
        local tc           =  tc_edge_l + tc_scan_step * (x_start + 0.5 - px0)

        for x=x_start,x_end do
            local tex_x = tc.x * MAX(MIN(tex_width,tex_clamp_x),0)
            local tex_y = tc.y * MAX(MIN(tex_height,tex_clamp_y),0)

            n = n + 1
            LIST[n] =  {x=x,y=y,tx=tex_x,ty=tex_y}
            if not LUT[y] then LUT[y] = {} end
            LUT[y][x] = true
            if caller then caller(x,y,tex_x,tex_y) end

            tc = tc + tc_scan_step
        end
        tc_edge_l = tc_edge_l + tc_step_l
        tc_step_r = tc_edge_r + tc_step_r
    end
end

local function draw_textured_flat_bottom_triangle(v0,v1,v2,texture,points,caller)
    local v0x,v0y,v0z = v0.pos.x,v0.pos.y,v0.pos.z
    local v1x,v1y,v1z = v1.pos.x,v1.pos.y,v1.pos.z
    local v2x,v2y,v2z = v2.pos.x,v2.pos.y,v2.pos.z
    local LIST,LUT = points.list,points.LUT
    local m0 = (v1x - v0x) / (v1y - v0y)
    local m1 = (v2x - v0x) / (v2y - v0y)
    local y_start = CEIL(v0y - 0.5)
    local y_end   = CEIL(v2y - 0.5) - 1

    local tc_edge_l   = v0.tc
    local tc_edge_r   = v0.tc
    local tc_bottom_l = v1.tc
    local tc_bottom_r = v2.tc

    local tc_step_l = (tc_bottom_l - tc_edge_l) / (v1y - v0y)
    local tc_step_r = (tc_bottom_r - tc_edge_r) / (v2y - v0y)

    tc_edge_l = tc_edge_l + tc_step_l * (y_start + 0.5 - v0y)
    tc_edge_r = tc_edge_r + tc_step_r * (y_start + 0.5 - v0y)

    local tex_width   = texture.width
    local tex_height  = texture.height
    local tex_clamp_x = tex_width  - 1
    local tex_clamp_y = tex_height - 1

    local n = #LIST
    for y=y_start,y_end do 
        local px0     = m0 * (y + 0.5 - v0y) + v0x
        local px1     = m1 * (y + 0.5 - v0y) + v0x
        local x_start = CEIL (px0 - 0.5)
        local x_end   = CEIL (px1 - 0.5)

        local tc_scan_step = (tc_edge_r - tc_step_l) / (px1 - px0)
        local tc           =  tc_edge_l + tc_scan_step * (x_start + 0.5 - px0)


        for x=x_start,x_end do
            local tex_x = tc.x * MAX(MIN(tex_width,tex_clamp_x),0)
            local tex_y = tc.y * MAX(MIN(tex_height,tex_clamp_y),0)

            n = n + 1
            LIST[n] =  {x=x,y=y,tx=tex_x,ty=tex_y}
            if not LUT[y] then LUT[y] = {} end
            LUT[y][x] = true
            if caller then caller(x,y,tex_x,tex_y) end
            
            tc = tc + tc_scan_step
        end
        tc_edge_l = tc_edge_l + tc_step_l
        tc_step_r = tc_edge_r + tc_step_r
    end
end

local function get_textured_triangle_points(vertex0,vertex1,vertex2,texture,caller)
    local points = {list={},LUT={}}
    if vertex1.pos.y < vertex0.pos.y then vertex0,vertex1 = vertex1,vertex0 end
    if vertex2.pos.y < vertex1.pos.y then vertex1,vertex2 = vertex2,vertex1 end
    if vertex1.pos.y < vertex0.pos.y then vertex0,vertex1 = vertex1,vertex0 end
    if vertex0.pos.y == vertex1.pos.y then
        if vertex1.pos.x < vertex0.pos.x then vertex0,vertex1 = vertex1,vertex0 end
        draw_textured_flat_top_triangle(vertex0,vertex1,vertex2,texture,points,caller)
    elseif vertex1.pos.y == vertex2.pos.y then
        if vertex2.pos.x < vertex1.pos.x then vertex1,vertex2 = vertex2,vertex1 end
        draw_textured_flat_bottom_triangle(vertex0,vertex1,vertex2,texture,points,caller)
    else
        local alpha_split = (vertex1.pos.y-vertex0.pos.y) / (vertex2.pos.y-vertex0.pos.y)
        local split_vertex = vertex0.interpolate_to(vertex2,alpha_split)
        if vertex1.pos.x < split_vertex.x then
            draw_textured_flat_bottom_triangle(vertex0,vertex1,split_vertex,texture,points,caller)
            draw_textured_flat_top_triangle   (vertex1,split_vertex,vertex2,texture,points,caller)
        else
            draw_textured_flat_bottom_triangle(vertex0,split_vertex,vertex1,texture,points,caller)
            draw_textured_flat_top_triangle   (split_vertex,vertex1,vertex2,texture,points,caller)
        end
    end
end

return {
    create=get_textured_triangle_points
}