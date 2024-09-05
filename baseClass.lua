require("collision")

worldObj = Class()
function worldObj:init(args)

end

function worldObj:update()
    
end

function worldObj:draw()

end

entity = Class()
function entity:init(args)
    self.x = args.x or 0
    self.y = args.y or 0
    self.width = args.width or 100
    self.height = args.height or 100
    self.colliderTag = args.colliderTag or nil
    self.tag = args.tag or {"ent"}
end

function entity:update()

end

function entity:draw()
    if self.x ~= nil and self.y ~= nil and self.width ~= nil and self.height ~= nil then
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
end

function entity:collide()                
    if self.colliderTag ~= nil then
    for _, obj in ipairs(world) do
        if obj ~= self then
            if collisionSystem.AABB_Collision(self, obj) then
                for _, CollideTag in ipairs(obj.colliderTag) do
                    for _, selfCollideTag in ipairs(self.colliderTag) do
                        if CollideTag == selfCollideTag then
                            return true
                        end
                    end
                end
            end
        end
    end
    end
end

function entity:move(x, y)
    x = x or 0
    y = y or 0
    self.x = self.x + x
    self.y = self.y + y
end

function entity:moveAndCollide(x, y, slide)
    slide = slide or false
    self:move(x)
    if slide == true then
        if self:collide() then
            self:move(-x)
        end
    end
    self:move(0, y)
    if self:collide() then
        self:move(0, -y)
        if slide == false then
            self:move(-x)
        end
    end
end