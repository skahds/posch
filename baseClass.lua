require("collision")

worldObj = Class()
function worldObj:init(args)
    self.id = "worldObj"
end

function worldObj:update()
    
end

function worldObj:draw()

end

function worldObj:getID()
    return self.id
end

entity = Class(worldObj)
function entity:init(args)
    worldObj.init(self, args)

    self.id = "ent"
    self.x = args.x or 0
    self.y = args.y or 0
    self.width = args.width or 100
    self.height = args.height or 100
    self.colliderTag = args.colliderTag or nil
    --remember, basic tags are "ent"
    self.tag = args.tag or nil

    self.particles = {}
    self.image = args.image or nil
    self.render = {
        rotation = 0,
        scaleX = 1,
        scaleY = 1,
        ox = 0,
        oy = 0,
        drawDepth = 0,
    }
    
end

function entity:update()

end

function entity:draw()
    if self.image then
        love.graphics.draw(self.image, self.x, self.y, self.render.rotation, self.render.scaleX, self.render.scaleY, self.render.ox, self.render.oy)
    elseif self.x ~= nil and self.y ~= nil and self.width ~= nil and self.height ~= nil then
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
end

function entity:checkCollision()                
    if self.colliderTag ~= nil then
    for _, obj in ipairs(world) do
        if obj ~= self and obj.tag then
            if collisionSystem.AABB_Collision(self, obj) then
                for _, CollideTag in ipairs(obj.tag) do
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