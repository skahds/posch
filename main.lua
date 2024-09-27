require('broadcast')
require('class')
require('baseClass')
require('collision')
require('foundationClass')

require('player')
require('game.game')
require('game.generation')

globals = {}
sWidth = love.graphics.getWidth()
sHeight = love.graphics.getHeight()

world = {}

local camera = require 'libs/camera'
globals.cam = camera()
globals.cam:zoom(2)



function love.load()
    world = {}
    posch.call("@loaded")
end

function love.update(dt)
    posch.call("@update", dt)
    for i, obj in ipairs(world) do
        if type(obj.update) == "function" then
            obj:update(dt)
        end
    end

    globals.cam:lookAt(posch.get("playerXY").x, posch.get("playerXY").y)
    -- get player x and y
end

function love.draw()
    globals.cam:attach()
    posch.call("@render")

    -- for sorting for drawDepth
    local drawableList = {}
    for i, obj in ipairs(world) do
        if type(obj.draw) == "function" then
            table.insert(drawableList, obj)
        end
    end
    table.sort(drawableList, function (a, b)
        if a.drawDepth ~= b.drawDepth then
            return a.render.drawDepth < b.render.drawDepth
        else
            return a.y < b.y
        end
    end)
    for i, obj in ipairs(drawableList) do
        obj:draw()
    end

    posch.call("@renderedEntity")
    globals.cam:detach()

end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
end

