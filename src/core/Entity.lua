local Vector2D = require("src.utils.Vector2D")
local Observable = require("src.utils.Observable")

local Entity = {}
Entity.__index = Entity

function Entity.new(x, y, type)
    local self = setmetatable({}, Entity)
    self.position = Vector2D.new(x, y)
    self.type = type
    self.health = 100
    self.observable = Observable.new()
    return self
end

function Entity:update(dt, ecosystem)
    -- To be overridden by subclasses
end

function Entity:move(dx, dy)
    self.position:add(Vector2D.new(dx, dy))
    self.observable:notify("moved", self)
end

function Entity:takeDamage(amount)
    self.health = math.max(0, self.health - amount)
    if self.health == 0 then
        self.observable:notify("died", self)
    end
end

return Entity