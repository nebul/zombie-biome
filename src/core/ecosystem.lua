local Grid = require("src.core.Grid")
local Config = require("src.config.Config")
local EntityFactoryRegistry = require("src.factories.EntityFactoryRegistry")

local Ecosystem = {}
Ecosystem.__index = Ecosystem

function Ecosystem.new()
    local self = setmetatable({}, Ecosystem)
    self.grid = Grid.new(Config.GRID_WIDTH, Config.GRID_HEIGHT)
    self.entities = {}
    self.entitiesToRemove = {}
    self.config = Config
    self.entityFactoryRegistry = EntityFactoryRegistry
    return self
end

function Ecosystem:initialize()
    for i = 1, self.config.INITIAL_ZOMBIES do
        local zombieFactory = self.entityFactoryRegistry.createFactory("zombie")
        self:addEntity(zombieFactory:createEntity())
    end
    for i = 1, self.config.INITIAL_SURVIVORS do
        local survivorFactory = self.entityFactoryRegistry.createFactory("survivor")
        self:addEntity(survivorFactory:createEntity())
    end
end

function Ecosystem:addEntity(entity)
    if #self.entities < self.config.MAX_ENTITIES and self.grid:addEntity(entity) then
        table.insert(self.entities, entity)
        entity.observable:addObserver("died", function()
            self:scheduleEntityRemoval(entity)
        end)
        return true
    end
    return false
end

function Ecosystem:scheduleEntityRemoval(entity)
    table.insert(self.entitiesToRemove, entity)
end

function Ecosystem:removeEntity(entity)
    if not entity then return false end
    
    local entityIndex = nil
    for i, e in ipairs(self.entities) do
        if e == entity then
            entityIndex = i
            break
        end
    end
    
    if entityIndex then
        self.grid:removeEntity(entity)
        table.remove(self.entities, entityIndex)
        return true
    end
    
    return false
end

function Ecosystem:processEntityRemovals()
    for _, entity in ipairs(self.entitiesToRemove) do
        self:removeEntity(entity)
    end
    self.entitiesToRemove = {}
end

function Ecosystem:update(dt)
    for _, entity in ipairs(self.entities) do
        entity:update(dt, self)
    end
    self:processEntityRemovals()
    self:spawnResources()
end

function Ecosystem:spawnResources()
    if #self.entities < self.config.MAX_ENTITIES and math.random() < self.config.RESOURCE_SPAWN_RATE then
        local resourceFactory = self.entityFactoryRegistry.createFactory("resource")
        local resource = resourceFactory:createEntity()
        self:addEntity(resource)
    end
end

function Ecosystem:getEntitiesInRange(position, range)
    return self.grid:getEntitiesInRange(position, range)
end

function Ecosystem:moveEntity(entity, newPosition)
    if not entity or not newPosition then
        print("Error: Invalid entity or new position in Ecosystem:moveEntity")
        return false
    end
    return self.grid:moveEntity(entity, newPosition)
end

return Ecosystem