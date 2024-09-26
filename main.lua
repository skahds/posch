require('class')
require('player')
require('baseClass')
require('collision')
require('foundationClass')
require('broadcast')

sWidth = love.graphics.getWidth()
sHeight = love.graphics.getHeight()

world = {}



function love.load()
    world = {}
    posch.call("@loaded")
end

function love.update(dt)
    for i, obj in ipairs(world) do
        if type(obj.update) == "function" then
            obj:update(dt)
        end
    end
end

function love.draw()
    for i, obj in ipairs(world) do
        if type(obj.draw) == "function" then
            obj:draw()
        end
    end
end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
end

