collisionSystem = {}

function collisionSystem.AABB_Collision(a, b)
    return a.x < b.x + b.width and
        a.x + a.width > b.x and
        a.y < b.y + b.height and
        a.y + a.height > b.y
end

-- current colliderTag = ent

-- function checkCollision()
--     for i, obj in ipairs(world) do
--         for e = i+1, #world do

--         end
--     end
-- end