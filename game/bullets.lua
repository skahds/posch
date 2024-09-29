local poes = posch.entities

poes.basic_bullet = Class(projectile)
local basic_bullet = poes.basic_bullet
function basic_bullet:init(args)
    projectile.init(self, args)

    self.bulletType = args.bulletType or posch.bullets.basic_bullet
    for k, v in pairs(self.bulletType) do
        self[k] = v
    end

    self.x = self.x+self.width/2
    self.y = self.y+self.height/2

    self.render.drawDepth = -1
    self.team = args.team or "player"
end

function basic_bullet:collided(obj)
    if obj.team ~= "player" then
        self:delete()
    end
end

function basic_bullet:draw()
    if self.image then
        love.graphics.draw(self.image, self.x, self.y, self.direction, self.render.scaleX, self.render.scaleY, self.render.ox, self.render.oy)
    elseif self.x ~= nil and self.y ~= nil and self.width ~= nil and self.height ~= nil then
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
end


posch.bullets = {
    basic_bullet = {
        id = "basic_bullet",
        width = 8,
        height = 12,
        image = love.graphics.newImage("assets/image/basic_bullet.png"),
        speed = 5,
        colliderTag = {"ent"},
    }

}