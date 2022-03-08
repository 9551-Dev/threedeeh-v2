local display_graphics = require("graphics.display")
local shapes = require("tools.shapes")

local cube = shapes.create_cube(1)
local lines = cube.shape.lines
local points = cube.shape.points

local w,h = term.getSize()

term.clear()

for i=1,#lines-1,2 do
    local v1i,v2i = lines[i],lines[i+1]
    local sx,sy,sz = points[(v1i-1)*3+1],points[(v1i-1)*3+2],points[(v1i-1)*3+3]    
    local ex,ey,ez = points[(v2i-1)*3+1],points[(v2i-1)*3+2],points[(v2i-1)*3+3]
    --print(sx,sy,ex,ey)
    sx,sy = display_graphics.transform_no_vector(sx,sy,w,h)
    ex,ey = display_graphics.transform_no_vector(ex,ey,w,h)
    --print(sx,sy,ex,ey)
    --sleep(5)
    paintutils.drawLine(sx,sy,ex,ey,colors.white)
end
sleep(2)
