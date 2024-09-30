posch.guns = {}

local pons = posch.guns
pons.basic_gun = {
    name = "Basic Gun",
    bulletClass = posch.entities.basic_bullet,
    bullet = posch.bullets.basic_bullet,
    timeBetweenShot = 0.2,
    image = love.graphics.newImage("assets/image/basic_gun.png")
}

pons.triple_minigun = {
    name = "Triple Minigun",
    bulletClass = posch.entities.basic_bullet,
    bullet = posch.bullets.basic_bullet,
    timeBetweenShot = 0.1,
    image = love.graphics.newImage("assets/image/triple_minigun.png"),

    onActive = function (selfEnt)
        for i=-1, 1 do
            selfEnt:shoot(selfEnt.gun,
            posch.get("relativeMouseXY").x,
            posch.get("relativeMouseXY").y,
            {x=selfEnt.x+selfEnt.width/2, y=selfEnt.y+selfEnt.height/2},
            {degree = i*30})
        end
    end
}