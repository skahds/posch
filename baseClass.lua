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

    self.particles = {}
end

function entity:update()

end

function entity:draw()
    if self.x ~= nil and self.y ~= nil and self.width ~= nil and self.height ~= nil then
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
end

function entity:checkCollision()                
    if self.colliderTag ~= nil then
    for _, obj in ipairs(world) do
        if obj ~= self then
            if collisionSystem.AABB_Collision(self, obj) then
                for _, CollideTag in ipairs(obj.colliderTag) do
                    for _, selfCollideTag in ipairs(self.colliderTag) do
                        if CollideTag == selfCollideTag then
                            return obj
                        end
                    end
                end
            end
        end
    end
    end
end

function entity:collided(collidingEnt)
    print("bump")
end

function entity:move(x, y)
    x = x or 0
    y = y or 0
    self.x = self.x + x
    self.y = self.y + y
end

--extraComp is a table, slide = {perfectAlign=true/false}
--perfectAlign is optional
function entity:moveAndCollide(x, y, extraComp)
    extraComp = extraComp or {}
    
    local slide = extraComp.slide or false
    local perfectAlign = false

    if slide then
    perfectAlign = extraComp.slide.perfectAlign or false
    end

    self:move(x)
    -- if sliding is enabled, we want to check collision twice
    if slide  then
        local collisionObjx = self:checkCollision()
        if collisionObjx then
            -- trigger both obj's collided
            self:collided(collisionObjx)
            collisionObjx:collided(self)
            
            if perfectAlign == false then
                self:move(-x)
            else
                if self.x < collisionObjx.x then
                    self.x = (collisionObjx.x - self.width)
                else
                    self.x = (collisionObjx.x+collisionObjx.width)
                end
            end

        end
    end
    self:move(0, y)
    local collisionObjy = self:checkCollision()
    if collisionObjy then
        -- trigger both obj's collided
        self:collided(collisionObjy)
        collisionObjy:collided(self)
        
        if perfectAlign == false then
            self:move(0, -y)
        else
            if self.y > collisionObjy.y then
                self.y = (collisionObjy.y + collisionObjy.height)
            else
                self.y = (collisionObjy.y - self.height)
            end
        end

        if slide == false then
            self:move(-x)
        end
    end
end