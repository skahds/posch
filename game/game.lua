local playerEnt = nil
local debugFont = nil
local newCursor = nil
posch.on("@loaded", function ()
    local poes = posch.entities


    debugFont = love.graphics.newFont(40)
    newCursor = love.graphics.newImage('assets/image/shootingCursor.png')
    love.mouse.setVisible(false)

    table.insert(world, poes.player:new({x=120, y=120, width=12, height=15, speed=200, colliderTag={"ent"}}))

    for i, obj in ipairs(world) do
        if obj:getID() == "player" then
            playerEnt = obj
            break
        end
    end

    if playerEnt then
        posch.updateStorage("playerXY", {x=playerEnt.x, y=playerEnt.y})
    end


end)

posch.on("@render:render", function ()
    love.graphics.setBackgroundColor(0.7, 0.3, 0.2)
end)

posch.on("@update", function ()


    posch.updateStorage("playerXY", {x=playerEnt.x, y=playerEnt.y})
    posch.updateStorage("isShootDown", love.mouse.isDown(1))

    local cameraX, cameraY = globals.cam:position()
    posch.updateStorage("relativeMouseXY", {x=playerEnt.x+(love.mouse.getX()-sWidth/2), y=playerEnt.y+(love.mouse.getY()-sHeight/2)})

    globals.cam:lookAt((posch.get("playerXY").x+(love.mouse.getX()-sWidth/2)/15),
    (posch.get("playerXY").y+(love.mouse.getY()-sHeight/2)/15))
end)

posch.on("@lazyUpdate", function ()
    for i=#world, 1, -1 do
        local obj = world[i]
        if obj:getID() == "basic_bullet" then
            if obj:getDistance(posch.get("playerXY")) > 600 then
                obj:delete()
            end
        end
    end
end)

posch.on("mouseReleased", function ()
    -- for i=#world, 1, -1 do
    --     local obj = world[i]
    --     if type(obj.triggerShoot) == "function" then
    --         obj:triggerShoot()
    --     end
    -- end
end)

posch.on("@render:renderOutsideCamera", function ()
    love.graphics.setFont(debugFont)
    love.graphics.print(playerEnt.gun.name)
    love.graphics.draw(newCursor, love.mouse.getX()-(newCursor:getWidth()/2*globals.cam.scale), love.mouse.getY()-(newCursor:getHeight()/2*globals.cam.scale), 0, globals.cam.scale)
end)
