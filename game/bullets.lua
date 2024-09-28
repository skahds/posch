local poes = posch.entities

poes.basic_bullet = Class(projectile)
local basic_bullet = poes.basic_bullet
function basic_bullet:init(args)
    projectile.init(self, args)
    self.width = 12
    self.height = 8

    self.x = self.x+self.width/2
    self.y = self.y+self.height/2

    
    self.id = "basic_bullet"
    self.image = love.graphics.newImage("assets/image/basic_bullet.png")
    self.speed = 5
    self.colliderTag = {"ent"}
    self.render.drawDepth = 1
    
    self.render.rotation = self.direction
    self.render.drawDepth = -1
    self.team = "player"
end

function basic_bullet:collided(obj)
    if obj.team ~= "player" then
        self:delete()
    end
end