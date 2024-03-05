local EntityFactory = require("src.factories.EntityFactory")
local Resource = require("src.entities.Resource")
local Config = require("src.config.Config")

local ResourceFactory = setmetatable({}, {__index = EntityFactory})
ResourceFactory.__index = ResourceFactory

function ResourceFactory.new()
    return setmetatable(EntityFactory.new(), ResourceFactory)
end

function ResourceFactory:createEntity(x, y)
    return self:createResource(x, y)
end

function ResourceFactory:createResource(x, y)
    return Resource.new(
        x or math.random(1, Config.GRID_WIDTH),
        y or math.random(1, Config.GRID_HEIGHT)
    )
end

return ResourceFactory
