local Entity = require("src.core.Entity")
local FleeingBehavior = require("src.behaviors.FleeingBehavior")

local Survivor = setmetatable({}, {__index = Entity})
Survivor.__index = Survivor

function Survivor.new(x, y)
    local self = setmetatable(Entity.new(x, y, "survivor"), Survivor)
    self.behavior = FleeingBehavior.new()
    self.resources = 0
    self.hunger = 0
    return self
end

function Survivor:update(dt, ecosystem)
    Entity.update(self, dt, ecosystem)
    self.behavior:execute(self, dt, ecosystem)
    self:updateHunger(dt, ecosystem)
    self:searchForResources(ecosystem, dt)
end

function Survivor:updateHunger(dt, ecosystem)
    self.hunger = self.hunger + dt * ecosystem.config.HUNGER_RATE
    if self.hunger > 100 then
        self.health = math.max(0, self.health - dt * ecosystem.config.HEALTH_DECREMENT_RATE)
        if self.health == 0 then
            self.observable:notify("died", self)
        end
    end
end


function Survivor:searchForResources(ecosystem, dt)
    local nearestResource = nil
    local minDistance = math.huge
    local nearbyEntities = ecosystem:getEntitiesInRange(self.position, ecosystem.config.SURVIVOR_VISION_RANGE)
    for _, entity in ipairs(nearbyEntities) do
        if entity.type == "resource" then
            local distance = self.position:distance(entity.position)
            if distance < minDistance then
                minDistance = distance
                nearestResource = entity
            end
        end
    end
    if nearestResource then
        local direction = nearestResource.position:clone():subtract(self.position):normalize()
        self.behavior:move(self, direction, ecosystem.config.SURVIVOR_SPEED, dt, ecosystem)
        if self.position:distance(nearestResource.position) <= 1.5 then
            self:collectResource(nearestResource, ecosystem)
        end
    end
end

function Survivor:collectResource(resource, ecosystem)
    self.resources = self.resources + resource.value
    self.hunger = math.max(0, self.hunger - resource.value)
    ecosystem:removeEntity(resource)
    self.observable:notify("collected_resource", {collector = self, resource = resource})
end

return Survivor