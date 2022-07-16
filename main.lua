local display_graphics = require("graphics.display")
local triangle = require("graphics.rasterize")
local mapi = require("math.api")
local color = require("graphics.colors")
local w,h = term.getSize()
w,h = w*2,h*3

local pixelbox = require("lib.pixelbox")
local win = window.create(term.current(),1,1,w/2,h/3-1)
local dbug = window.create(term.current(),1,h/3,w/2,1)

local box = pixelbox.new(win)
local color = color.create(nil,{[colors.black]=true})

local function main(old,dir)
    local objects   = require("objects")              .make(dir)
    local shape     = require("tools.shapes")         .make(dir)
    local rotationm = require("math.matrice.rotation").make(dir)

    package.path = old
    local frames = {}
    return {run=function()
        local st = os.epoch("utc")
        for i=1,math.huge do
            box:clear(colors.black) 
            local cube = shape.new.pyramid(1.5)
            local lines = cube.shape.lines
            local triangles = cube.shape.triangles
            local points = cube.shape.points
            for i=1,#cube.shape.points,3 do
                local object_matrix = objects.new.mat(1,3,
                    cube.shape.points[i],
                    cube.shape.points[i+1],
                    cube.shape.points[i+2]
                )
                local rotation = rotationm.create_rotation_x(math.rad((math.sin(os.epoch("utc")/2000)+1)*180))
                local rotation = rotation*rotationm.create_rotation_y(math.rad((math.sin(os.epoch("utc")/1000)+1)*180))
                cube.shape.points[i],cube.shape.points[i+1],cube.shape.points[i+2] = table.unpack(rotation*object_matrix)
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
                --box:set_line(sx,sy,ex,ey,colors.red)
            end
            box:push_updates()
            box:draw()
            local ct = os.epoch("utc")
            os.queueEvent("update")
            os.pullEvent()
            local passed = ct-st
            dbug.clear()
            dbug.setCursorPos(1,1)
            dbug.write(math.floor(i/(passed/1000)) .. " FPS" .. "       triangles:"..(#triangles/3).."        frame:"..i)
            table.insert(frames,math.floor(i/(passed/1000)))
        end
    end}
end

return main