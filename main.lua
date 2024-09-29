require('broadcast')
require('class')
require('baseClass')
require('collision')
require('gameClasses')

require('game.player')
require('game.game')
require('game.generation')
require('game.bullets')
require('game.guns')

globals = {}
sWidth = love.graphics.getWidth()
sHeight = love.graphics.getHeight()

world = {}

local camera = require 'libs/camera'
globals.cam = camera()
globals.cam:zoom(2)

local lazyUpdateCount = 0

function love.load()
    world = {}
    posch.call("@loaded")
end

function love.update(dt)
    posch.call("@update", dt)
    lazyUpdateCount = lazyUpdateCount + 1
    if lazyUpdateCount >= 10 then
        posch.call("@lazyUpdate")
        lazyUpdateCount = 0
    end
    
    for i, obj in ipairs(world) do
        if type(obj.update) == "function" then
            obj:update(dt)
        end
    end


    -- get player x and y
end

function love.draw()
    globals.cam:attach()
    posch.call("@render:render")

    -- for sorting for drawDepth
    local drawableList = {}
    for i, obj in ipairs(world) do
        if type(obj.draw) == "function" then
            table.insert(drawableList, obj)
        end
    end
    table.sort(drawableList, function (a, b)
        if a.render.drawDepth ~= b.render.drawDepth then
            return a.render.drawDepth < b.render.drawDepth
        else
            return a.y < b.y
        end
    end)
    for i, obj in ipairs(drawableList) do
        obj:draw()
    end
    globals.cam:detach()

    posch.call("@render:renderOutsideCamera")

end

function love.mousereleased(x, y, button)
    posch.call("mouseReleased", x, y, button)
end


function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
end

