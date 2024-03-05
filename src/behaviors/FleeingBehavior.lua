local Vector2D = require("src.utils.Vector2D")
local Config = require("src.config.Config")
local MovementBehavior = require("src.behaviors.MovementBehavior")
local Math = require("src.utils.Math")

local FleeingBehavior = setmetatable({}, {__index = MovementBehavior})
FleeingBehavior.__index = FleeingBehavior

function FleeingBehavior.new()
    return setmetatable(MovementBehavior.new(), FleeingBehavior)
end

function FleeingBehavior:execute(entity, dt, ecosystem)
    local nearestZombie = self:findNearestThreat(entity, ecosystem)

    if nearestZombie then

        local fleeDirection = Vector2D.new(
            entity.position.x - nearestZombie.position.x,
            entity.position.y - nearestZombie.position.y
        )
        
        if fleeDirection:magnitude() < 0.1 then
            local randomDirections = {
                Vector2D.new(1, 0), Vector2D.new(-1, 0),
                Vector2D.new(0, 1), Vector2D.new(0, -1),
                Vector2D.new(1, 1), Vector2D.new(-1, -1),
                Vector2D.new(1, -1), Vector2D.new(-1, 1)
            }
            fleeDirection = randomDirections[math.random(#randomDirections)]
        end
        
        self:move(entity, fleeDirection, ecosystem.config.SURVIVOR_SPEED, dt, ecosystem)
    else
        self:wander(entity, ecosystem.config.SURVIVOR_SPEED, dt, ecosystem)
    end
end

function FleeingBehavior:findNearestThreat(entity, ecosystem)
    local nearestZombie = nil
    local minDistance = math.huge
    
    local entitiesInRange = ecosystem:getEntitiesInRange(entity.position, ecosystem.config.SURVIVOR_VISION_RANGE)
    
    for _, potentialThreat in ipairs(entitiesInRange) do
        if potentialThreat.type == "zombie" then
            local distance = entity.position:distance(potentialThreat.position)
            if distance < minDistance then
                minDistance = distance
                nearestZombie = potentialThreat
            end
        end
    end
    
    return nearestZombie
end

return FleeingBehavior