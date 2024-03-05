local EntityFactory = require("src.factories.EntityFactory")
local Zombie = require("src.entities.Zombie")
local Config = require("src.config.Config")

local ZombieFactory = setmetatable({}, {__index = EntityFactory})
ZombieFactory.__index = ZombieFactory

function ZombieFactory.new()
    local self = EntityFactory.new()
    setmetatable(self, ZombieFactory)
    return self
end

function ZombieFactory:createEntity(x, y)
    return self:createZombie(x, y)
end

function ZombieFactory:createZombie(x, y)
    return Zombie.new(
        x or math.random(1, Config.GRID_WIDTH),
        y or math.random(1, Config.GRID_HEIGHT)
    )
end

return ZombieFactory