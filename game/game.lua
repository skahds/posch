local playerEnt = nil

posch.on("@loaded", function ()
    local poes = posch.entities

    love.graphics.setDefaultFilter("nearest", "nearest")

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

posch.on("@render", function ()
    love.graphics.setBackgroundColor(0.7, 0.3, 0.2)
end)

posch.on("@update", function ()
    posch.updateStorage("playerXY", {x=playerEnt.x, y=playerEnt.y})

    globals.cam:lookAt((posch.get("playerXY").x+(love.mouse.getX()-sWidth/2)/10), (posch.get("playerXY").y+(love.mouse.getY()-sHeight/2)/10))
end)