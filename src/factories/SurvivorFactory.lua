local EntityFactory = require("src.factories.EntityFactory")
local Survivor = require("src.entities.Survivor")
local Config = require("src.config.Config")

local SurvivorFactory = setmetatable({}, {__index = EntityFactory})
SurvivorFactory.__index = SurvivorFactory

function SurvivorFactory.new()
    return setmetatable(EntityFactory.new(), SurvivorFactory)
end

function SurvivorFactory:createEntity(x, y)
    return self:createSurvivor(x, y)
end

function SurvivorFactory:createSurvivor(x, y)
    return Survivor.new(
        x or math.random(1, Config.GRID_WIDTH),
        y or math.random(1, Config.GRID_HEIGHT)
    )
end

return SurvivorFactory
