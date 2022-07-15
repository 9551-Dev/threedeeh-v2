local display_graphics = require("graphics.display")
local triangle = require("graphics.graphic")
local rotationm = require("math.matrices.rotation")
local mapi = require("math.api")
local matrice = require("math.matrices.matrice_object")
local shapes = require("tools.shapes.cube")
local color = require("graphics.colors")
local w,h = term.getSize()
w,h = w*2,h*3

local pixelbox = require("graphics.pixelbox")
local box = pixelbox.new(term.current())

local color = color.create()

local count = 0

while true do
    box:clear(colors.black)
    local cube = shapes.create_cube(1.5)
    local lines = cube.shape.lines
    local triangles = cube.shape.triangles
    local points = cube.shape.points
    count = count + 2
    for i=1,#cube.shape.points,3 do
        local object_matrix = matrice.create(1,3,
            cube.shape.points[i],
            cube.shape.points[i+1],
            cube.shape.points[i+2]
        )
        local rotation = rotationm.create_rotation_x(0)
        local rotation = rotation*rotationm.create_rotation_y(math.rad(count%360))
        cube.shape.points[i],cube.shape.points[i+1],cube.shape.points[i+2] = unpack(rotation*object_matrix)
        cube.shape.points[i+2] = cube.shape.points[i+2]+2
    end
    for i=1,#triangles-2,3 do
        local v1i,v2i,v3i = triangles[i],triangles[i+1],triangles[i+2]
        local p1 = vector.new(points[(v1i-1)*3+1],points[(v1i-1)*3+2],points[(v1i-1)*3+3])
        local p2 = vector.new(points[(v2i-1)*3+1],points[(v2i-1)*3+2],points[(v2i-1)*3+3])
        local p3 = vector.new(points[(v3i-1)*3+1],points[(v3i-1)*3+2],points[(v3i-1)*3+3])
        triangles.cull_flags[i] = (p2:cross(p3)):dot(p1) > 0
        if not triangles.cull_flags[i] then
            local v1 = display_graphics.transform_vector(p1,w,h)
            local v2 = display_graphics.transform_vector(p2,w,h)
            local v3 = display_graphics.transform_vector(p3,w,h)
            local points = triangle.create(v1,v2,v3,function(x,y)
                box:set_pixel(x,y,color[i])
            end)
        end
    end
    for i=1,#lines-1,2 do   
        local v1i,v2i = lines[i],lines[i+1]
        local sx,sy,sz = points[(v1i-1)*3+1],points[(v1i-1)*3+2],points[(v1i-1)*3+3]    
        local ex,ey,ez = points[(v2i-1)*3+1],points[(v2i-1)*3+2],points[(v2i-1)*3+3]
        sx,sy = display_graphics.transform_no_vector(sx,sy,sz,w,h)
        ex,ey = display_graphics.transform_no_vector(ex,ey,ez,w,h)
        box:set_line(sx,sy,ex,ey,colors.red)
    end
    box:push_updates()
    box:draw()
    os.queueEvent("update")
    os.pullEvent()
end