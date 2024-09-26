posch.on("@loaded", function ()
    local poes = posch.entities
    table.insert(world, poes.player:new({x=120, y=120, width=10, height=10, speed=300, colliderTag={"ent"}}))

    table.insert(world, poes.wall:new({x=110+100, y=60+100, colliderTag={"ent"}}))
end)
