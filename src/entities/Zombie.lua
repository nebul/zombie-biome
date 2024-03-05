local Entity = require("src.core.Entity")
local HunterBehavior = require("src.behaviors.HunterBehavior")

local Zombie = setmetatable({}, {__index = Entity})
Zombie.__index = Zombie

function Zombie.new(x, y)
    local self = setmetatable(Entity.new(x, y, "zombie"), Zombie)
    self.behavior = HunterBehavior.new()
    self.infectionPower = 10
    return self
end

function Zombie:update(dt, ecosystem)
    Entity.update(self, dt, ecosystem)
    self.behavior:execute(self, dt, ecosystem)
    self:consumeEnergy(dt)
end

function Zombie:consumeEnergy(dt)
    self.health = math.max(0, self.health - dt * 2)
    if self.health == 0 then
        self.observable:notify("died", self)
    end
end

function Zombie:infectSurvivor(target, ecosystem)
    if target.type == "survivor" and math.random() < ecosystem.config.INFECTION_CHANCE then
        local newZombie = Zombie.new(target.position.x, target.position.y)
        ecosystem:removeEntity(target)
        ecosystem:addEntity(newZombie)
        self.observable:notify("infected", {infector = self, infected = newZombie})
    end
end

return Zombie