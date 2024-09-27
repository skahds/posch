require('baseClass')
posch.entities = {}
local poes = posch.entities

-- wall
poes.wall = Class(entity)
local wall = poes.wall
function wall:init(args)
    entity.init(self, args)

    self.width = args.width or 50
    self.height = args.height or 50
    self.image = args.image or love.graphics.newImage('assets/image/wall_tile.png')
    self.render.oy = 8
    self.tag = {"ent"}
end

--tile
poes.tile = Class(entity)
local tile = poes.tile
function tile:init(args)
    entity.init(self, args)

    self.width = args.width or 128
    self.height = args.height or 128
    self.render.drawDepth = 1000
    self.render.quad = love.graphics.newQuad(0, 0, self.width,self.height, self.image:getWidth(), self.image:getHeight())
end

function tile:draw()
    self.image:setWrap("repeat", "repeat")
    love.graphics.draw(self.image, self.render.quad, self.x, self.y, self.render.rotation, self.render.scaleX, self.render.scaleY, self.render.ox, self.render.oy)
end
-- player
poes.player = Class(entity)
local player = poes.player
function player:init(args)
    entity.init(self, args)

    self.id = "player"
    self.speed = args.speed or 400
    self.vx = 0
    self.vy = 0
    self.speedMult = 1
    self.render.drawDepth = 100
    self.tag = {"ent"}
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
end
