local ZombieFactory = require("src.factories.ZombieFactory")
local SurvivorFactory = require("src.factories.SurvivorFactory")
local ResourceFactory = require("src.factories.ResourceFactory")

local EntityFactoryRegistry = {}

function EntityFactoryRegistry.createFactory(entityType)
    local factoryMap = {
        zombie = ZombieFactory,
        survivor = SurvivorFactory,
        resource = ResourceFactory
    }

    local factoryClass = factoryMap[entityType]
    if factoryClass then
        return factoryClass.new()
    else
        error("Unknown entity type: " .. tostring(entityType))
    end
end

return EntityFactoryRegistry