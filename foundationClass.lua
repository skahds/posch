require('baseClass')
posch.entities = {}
local poes = posch.entities


poes.wall = Class(entity)
local wall = poes.wall
function wall:init(args)
    entity.init(self, args)

    self.width = args.width or 50
    self.height = args.height or 50
end


poes.player = Class(entity)
local player = poes.player
function player:init(args)
    entity.init(self, args)

    self.speed = args.speed or 400
    self.vx = 0
    self.vy = 0
end

function player:update(dt)
    -- move func
    local lk = love.keyboard
    if lk.isDown("a") and not lk.isDown("d") then
        self.vx = -1
    elseif lk.isDown("d") and not lk.isDown("a") then
        self.vx = 1
    elseif (lk.isDown("a") == false and lk.isDown("d") == false) or (lk.isDown("a") == true and lk.isDown("d") == true) then
        self.vx = 0
    end

    if lk.isDown("w") and not lk.isDown("s") then
        self.vy = -1
    elseif lk.isDown("s") and not lk.isDown("w") then
        self.vy = 1
    elseif (lk.isDown("w") == false and lk.isDown("s") == false) or (lk.isDown("w") == true and lk.isDown("s") == true) then
        self.vy = 0
    end

    self:moveAndCollide(self.vx*self.speed*dt, self.vy*self.speed*dt, {slide={perfectAlign=true}})
end
