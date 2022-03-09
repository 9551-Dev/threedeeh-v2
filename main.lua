local display_graphics = require("graphics.display")
local rotationm = require("math.matrices.rotation")
local mapi = require("math.api")
local matrice = require("math.matrices.matrice_object")
local shapes = require("tools.shapes")

local cube = shapes.create_cube(1)
local lines = cube.shape.lines
local points = cube.shape.points

local w,h = term.getSize()


local count = 0
while true do
    count = count+0.01
    term.setBackgroundColor(colors.black)
    term.clear()
    for i=1,#cube.shape.points,3 do
        local object_matrix = matrice.create(1,3,
            cube.shape.points[i],
            cube.shape.points[i+1],
            cube.shape.points[i+2]
        )
        local rotation = rotationm.create_rotation_x(count%360)
        local rotation = rotation*rotationm.create_rotation_y
        cube.shape.points[i],cube.shape.points[i+1],cube.shape.points[i+2] = unpack(rotation*object_matrix)
    end
    for i=1,#lines-1,2 do
        local v1i,v2i = lines[i],lines[i+1]
        local sx,sy,sz = points[(v1i-1)*3+1],points[(v1i-1)*3+2],points[(v1i-1)*3+3]    
        local ex,ey,ez = points[(v2i-1)*3+1],points[(v2i-1)*3+2],points[(v2i-1)*3+3]
        sx,sy = display_graphics.transform_no_vector(sx,sy,w,h)
        ex,ey = display_graphics.transform_no_vector(ex,ey,w,h)
        paintutils.drawLine(sx,sy,ex,ey,colors.white)
    end
    sleep(0.1)
end