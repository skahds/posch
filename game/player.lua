poes = posch.entities
-- player
poes.player = Class(entity, shooter)
local player = poes.player
function player:init(args)
    entity.init(self, args)

    self.id = "player"
    self.speed = args.speed or 400
    self.vx = 0
    self.vy = 0
    self.speedMult = 1
    self.render.drawDepth = 0
    self.tag = {"ent", "player"}

    -- self.team = "player"
    self.gun = posch.guns.triple_minigun
    self.gun.currentTimeBetweenShot = 0
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

    if self.vy ~= 0 and self.vx ~= 0 then
        self.speedMult = 1 / math.sqrt(self.vx^2 + self.vy^2)
    else
        self.speedMult = 1
    end
    self:moveAndCollide(self.vx*self.speed*self.speedMult*dt, self.vy*self.speed*self.speedMult*dt, {slide={perfectAlign=true}})


    -- shootFunc
    if self.gun then
        if self.gun.timeBetweenShot > self.gun.currentTimeBetweenShot then
            self.gun.currentTimeBetweenShot = self.gun.currentTimeBetweenShot + dt
        else
            if posch.get("isShootDown") then
                self:triggerShoot()
                self.gun.currentTimeBetweenShot = 0
            end
        end
    end
end

function player:triggerShoot()
    if self.gun ~= nil then
        if self.gun.onActive == nil then
            local gun = self.gun
            local spawnCoord = {x=self.x+self.width/2, y=self.y+self.height/2}
            self:shoot(gun, posch.get("relativeMouseXY").x, posch.get("relativeMouseXY").y, spawnCoord)
        else
            self.gun.onActive(self)
        end
    end
end