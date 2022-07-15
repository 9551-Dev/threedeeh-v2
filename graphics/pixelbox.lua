--[[
    * api for easy interaction with drawing characters

    * single file implementation of GuiH pixelbox api
]]

local EXPECT = require("cc.expect").expect

local CEIL = math.ceil

local PIXELBOX = {}
local OBJECT = {}
local api = {}
local ALGO = {}
local graphic = {}

local chars = "0123456789abcdef"
graphic.to_blit = {}
for i = 0, 15 do
    graphic.to_blit[2^i] = chars:sub(i + 1, i + 1)
end

function PIXELBOX.INDEX_SYMBOL_CORDINATION(tbl,x,y,val)
    tbl[x+y*2-2] = val
    return tbl
end

function OBJECT:within(x,y)
    return x > 0
        and y > 0
        and x <= self.width*2
        and y <= self.height*3
end

function PIXELBOX.RESTORE(BOX,color,existing)
    BOX.CANVAS = api.createNDarray(1)
    BOX.UPDATES = api.createNDarray(1)
    BOX.CHARS = api.createNDarray(1)
    for y=1,BOX.height*3 do
        for x=1,BOX.width*2 do
            BOX.CANVAS[y][x] = color
        end
    end
    for y=1,BOX.height do
        for x=1,BOX.width do
            BOX.CHARS[y][x] = {symbol=" ",background=graphic.to_blit[color],fg="f"}
        end
    end
    getmetatable(BOX.CANVAS).__tostring = function() return "PixelBOX_SCREEN_BUFFER" end
end

function OBJECT:push_updates()
    self.symbols = api.createNDarray(2)
    self.lines = api.create_blit_array(self.height)
    local SYMBOL_COLORS = api.createNDarray(1)
    local SYMBOL_LUT =    api.createNDarray(2)
    getmetatable(self.symbols).__tostring=function() return "PixelBOX.SYMBOL_BUFFER" end
    setmetatable(self.lines,{__tostring=function() return "PixelBOX.LINE_BUFFER" end})
    for y,x_list in pairs(self.CANVAS) do
        for x,block_color in pairs(x_list) do
            local RELATIVE_X = CEIL(x/2)
            local RELATIVE_Y = CEIL(y/3)
            if self.UPDATES[RELATIVE_Y][RELATIVE_X] then
                local SYMBOL_POS_X = (x-1)%2+1
                local SYMBOL_POS_Y = (y-1)%3+1
                if not SYMBOL_LUT[RELATIVE_Y][RELATIVE_X][block_color] then
                    if not SYMBOL_COLORS[RELATIVE_Y][RELATIVE_X] then SYMBOL_COLORS[RELATIVE_Y][RELATIVE_X] = 0 end
                    SYMBOL_COLORS[RELATIVE_Y][RELATIVE_X] = SYMBOL_COLORS[RELATIVE_Y][RELATIVE_X] + 1
                    SYMBOL_LUT[RELATIVE_Y][RELATIVE_X][block_color] = true
                end
                self.symbols[RELATIVE_Y][RELATIVE_X] = PIXELBOX.INDEX_SYMBOL_CORDINATION(
                    self.symbols[RELATIVE_Y][RELATIVE_X],
                    SYMBOL_POS_X,SYMBOL_POS_Y,
                    block_color
                )
            end
        end
    end
    for y=1,self.height do
        for x=1,self.width do
            local color_block = self.symbols[y][x]
            if self.UPDATES[y][x] then
                local char,fg,bg = " ",colors.black,color_block[1]
                if SYMBOL_COLORS[y][x] > 1 then
                    char,fg,bg = graphic.build_drawing_char(color_block)
                end
                self.CHARS[y][x] = {symbol=char, background=graphic.to_blit[bg], fg=graphic.to_blit[fg]}
                self.lines[y] = {
                    self.lines[y][1]..char,
                    self.lines[y][2]..graphic.to_blit[fg],
                    self.lines[y][3]..graphic.to_blit[bg]
                }
            else
                local prev_data = self.CHARS[y][x]
                self.lines[y] = {
                    self.lines[y][1]..prev_data.symbol,
                    self.lines[y][2]..prev_data.fg,
                    self.lines[y][3]..prev_data.background
                }
            end
        end
    end
    self.UPDATES = api.createNDarray(1)
end

function OBJECT:clear(color)
    PIXELBOX.RESTORE(self,color)
end

function OBJECT:draw()
    for y,line in ipairs(self.lines) do
        self.term.setCursorPos(1,y)
        self.term.blit(
            table.unpack(line)
        )
    end
end

function OBJECT:set_pixel(x,y,color)
    local RELATIVE_X = CEIL(x/2)
    local RELATIVE_Y = CEIL(y/3)
    self.UPDATES[RELATIVE_Y][RELATIVE_X] = true
    self.CANVAS[y][x] = color
end
function OBJECT:set_line(x1,y1,x2,y2,color,thiccness)
    local points = ALGO.get_line_points(x1,y1,x2,y2)
    for _,point in ipairs(points) do
        if self:within(point.x,point.y) then
            local RELATIVE_X = CEIL(point.x/2)
            local RELATIVE_Y = CEIL(point.y/3)
            self.UPDATES[RELATIVE_Y][RELATIVE_X] = true
            self.CANVAS[point.y][point.x] = color
        end
    end
end

function PIXELBOX.new(terminal,bg,existing)
    EXPECT(1,terminal,"table")
    EXPECT(2,bg,"number","nil")
    EXPECT(3,existing,"table","nil")
    local bg = bg or terminal.getBackgroundColor() or colors.black
    local BOX = {}
    local w,h = terminal.getSize()
    BOX.term = setmetatable(terminal,{__tostring=function() return "term_object" end})
    BOX.width = w
    BOX.height = h
    PIXELBOX.RESTORE(BOX,bg,existing)
    return setmetatable(BOX,{__index = OBJECT})
end
function ALGO.get_line_points(startX, startY, endX, endY)
    local points = {}
    startX,startY,endX,endY = math.floor(startX),math.floor(startY),math.floor(endX),math.floor(endY)
    if startX == endX and startY == endY then return {x=startX,y=startY} end
    local minX = math.min(startX, endX)
    local maxX, minY, maxY
    if minX == startX then minY,maxX,maxY = startY,endX,endY
    else minY,maxX,maxY = endY,startX,startY end
    local xDiff,yDiff = maxX - minX,maxY - minY
    if xDiff > math.abs(yDiff) then
        local y = minY
        local dy = yDiff / xDiff
        for x = minX, maxX do
            table.insert(points,{x=x,y=math.floor(y + 0.5)})
            y = y + dy
        end
    else
        local x,dx = minX,xDiff / yDiff
        if maxY >= minY then
            for y = minY, maxY do
                table.insert(points,{x=math.floor(x + 0.5),y=y})
                x = x + dx
            end
        else
            for y = minY, maxY, -1 do
                table.insert(points,{x=math.floor(x + 0.5),y=y})
                x = x - dx
            end
        end
    end
    return points
end

function api.createNDarray(n, tbl)
    tbl = tbl or {}
    if n == 0 then return tbl end
    setmetatable(tbl, {__index = function(t, k)
        local new = api.createNDarray(n - 1)
        t[k] = new
        return new
    end})
    return tbl
end

function api.create_blit_array(count)
    local out = {}
    for i=1,count do
        out[i] = {"","",""}
    end
    return out
end

function api.merge_tables(...)
    local out = {}
    for k,v in pairs({...}) do
        for _k,_v in pairs(v) do table.insert(out,_v) end
    end
    return out
end

function graphic.build_drawing_char(arr,mode)
    local cols,fin,char,visited = {},{},{},{}
    local entries = 0
    for k,v in pairs(arr) do
        cols[v] = cols[v] ~= nil and
            {count=cols[v].count+1,c=cols[v].c}
            or (function() entries = entries + 1 return {count=1,c=v} end)()
    end
    for k,v in pairs(cols) do
        if not visited[v.c] then
            visited[v.c] = true
            if entries == 1 then table.insert(fin,v) end
            table.insert(fin,v)
        end
    end
    table.sort(fin,function(a,b) return a.count > b.count end)
    for k=1,6 do
        if arr[k] == fin[1].c then char[k] = 1
        elseif arr[k] == fin[2].c then char[k] = 0
        else char[k] = mode and 0 or 1 end
    end
    if char[6] == 1 then for i = 1, 5 do char[i] = 1-char[i] end end
    local n = 128
    for i = 0, 4 do n = n + char[i+1]*2^i end
    return string.char(n),char[6] == 1 and fin[2].c or fin[1].c,char[6] == 1 and fin[1].c or fin[2].c
end

return PIXELBOX