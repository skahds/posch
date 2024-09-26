posch.on("@loaded", function ()
    table.insert(world, entity:new({x=300, y=200, width=150, height=150, colliderTag={"ent"}}))
    table.insert(world, player:new({x=20, y=20, width=100, height=100, speed=300, colliderTag={"ent"}}))
end)
