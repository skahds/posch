require('baseClass')
movingBox = Class(entity)
function movingBox:update(dt)
    self:moveAndCollide(300*dt, 100*dt, true)
end