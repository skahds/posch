require('class')
require('player')
require('baseClass')
require('collision')
require('foundationClass')

sWidth = love.graphics.getWidth()
sHeight = love.graphics.getHeight()

world = {}


function love.load()
    world = {
    entity:new({x=500, y=100, width=100, height=550, colliderTag={"ent"}}),
    movingBox:new({x=100, y=100, width=100, height=100, colliderTag={"ent"}})
    }
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
