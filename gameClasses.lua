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
    self.render.drawDepth = -1000
    self.render.quad = love.graphics.newQuad(0, 0, self.width,self.height, self.image:getWidth(), self.image:getHeight())
end

function tile:draw()
    self.image:setWrap("repeat", "repeat")
    love.graphics.draw(self.image, self.render.quad, self.x, self.y, self.render.rotation, self.render.scaleX, self.render.scaleY, self.render.ox, self.render.oy)
end
