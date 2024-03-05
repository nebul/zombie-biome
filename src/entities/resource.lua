local Entity = require("src.core.Entity")

local Resource = setmetatable({}, {__index = Entity})
Resource.__index = Resource

function Resource.new(x, y)
    local self = setmetatable(Entity.new(x, y, "resource"), Resource)
    self.value = math.random(10, 50)
    self.lifespan = math.random(50, 100)
    return self
end

function Resource:update(dt, ecosystem)
    Entity.update(self, dt, ecosystem)
    self.lifespan = self.lifespan - dt
    if self.lifespan <= 0 then
        self.observable:notify("expired", self)
        ecosystem:removeEntity(self)
    end
end

return Resource