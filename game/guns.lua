posch.guns = {}

local pons = posch.guns
pons.basic_gun = {
    name = "Basic Gun",
    bulletClass = posch.entities.basic_bullet,
    bullet = posch.bullets.basic_bullet,
    timeBetweenShot = 0.2,
}

pons.triple_minigun = {
    name = "Triple Minigun",
    bulletClass = posch.entities.basic_bullet,
    bullet = posch.bullets.basic_bullet,
    timeBetweenShot = 0.1,

    onActive = function (selfEnt)
        for i=-1, 1 do
            selfEnt:shoot(selfEnt.gun,
            posch.get("relativeMouseXY").x,
            posch.get("relativeMouseXY").y,
            {x=selfEnt.x, y=selfEnt.y},
            {degree = i*30})
        end
    end
}