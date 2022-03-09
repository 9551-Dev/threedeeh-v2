local display_graphics = require("graphics.display")
local rotationm = require("math.matrices.rotation")
local mapi = require("math.api")
local matrice = require("math.matrices.matrice_object")
local shapes = require("tools.shapes")

local cube = shapes.create_cube(1)
local lines = cube.shape.lines
local points = cube.shape.points

local w,h = term.getSize()


term.setBackgroundColor(colors.black)
term.clear()

for i=1,#cube.shape.points,3 do
    local object_matrix = matrice.create(1,3,
        cube.shape.points[i],
        cube.shape.points[i+1],
        cube.shape.points[i+2]+1.5
    )
    local rotation = rotationm.create_rotation_x(0)
    local rotation = rotation*rotationm.create_rotation_y(0)
    cube.shape.points[i],cube.shape.points[i+1],cube.shape.points[i+2] = unpack(rotation*object_matrix)
end
for i=1,#lines-1,2 do
    local v1i,v2i = lines[i],lines[i+1]
    local sx,sy,sz = points[(v1i-1)*3+1],points[(v1i-1)*3+2],points[(v1i-1)*3+3]    
    local ex,ey,ez = points[(v2i-1)*3+1],points[(v2i-1)*3+2],points[(v2i-1)*3+3]
    sx,sy = display_graphics.transform_no_vector(sx,sy,sz,w,h)
    ex,ey = display_graphics.transform_no_vector(ex,ey,ez,w,h)
    paintutils.drawLine(sx,sy,ex,ey,colors.white)
end