local Zombie = require("src.entities.Zombie")
local Survivor = require("src.entities.Survivor")
local Resource = require("src.entities.Resource")
local Config = require("src.config.Config")

local EntityFactory = {}
EntityFactory.__index = EntityFactory

function EntityFactory.new()
    return setmetatable({}, EntityFactory)
end

function EntityFactory:createEntity(type, x, y)
    if type == "zombie" then
        return Zombie.new(x or math.random(1, Config.GRID_WIDTH), y or math.random(1, Config.GRID_HEIGHT))
    elseif type == "survivor" then
        return Survivor.new(x or math.random(1, Config.GRID_WIDTH), y or math.random(1, Config.GRID_HEIGHT))
    elseif type == "resource" then
        return Resource.new(x or math.random(1, Config.GRID_WIDTH), y or math.random(1, Config.GRID_HEIGHT))
    else
        error("Unknown entity type: " .. tostring(type))
    end
end

return EntityFactory