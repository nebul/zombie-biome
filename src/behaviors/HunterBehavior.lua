local Vector2D = require("src.utils.Vector2D")
local MovementBehavior = require("src.behaviors.MovementBehavior")
local Math = require("src.utils.Math")

local HunterBehavior = setmetatable({}, {__index = MovementBehavior})
HunterBehavior.__index = HunterBehavior

function HunterBehavior.new()
    return setmetatable(MovementBehavior.new(), HunterBehavior)
end

function HunterBehavior:execute(entity, dt, ecosystem)
    local target = self:findNearestTarget(entity, ecosystem)

    if target then
        local direction = Vector2D.new(
            target.position.x - entity.position.x,
            target.position.y - entity.position.y
        )
        
        if self:isAdjacentTo(entity, target) then
            if entity.infectSurvivor then
                entity:infectSurvivor(target, ecosystem)
            else
                print("Error:  entity does not have infectSurvivor method")
            end
        else
            self:move(entity, direction, ecosystem.config.ZOMBIE_SPEED, dt, ecosystem)
        end
    else
        self:wander(entity, ecosystem.config.ZOMBIE_SPEED, dt, ecosystem)
    end
end

function HunterBehavior:findNearestTarget(entity, ecosystem)
    local nearestTarget = nil
    local minDistance = math.huge
    
    local entitiesInRange = ecosystem:getEntitiesInRange(entity.position, ecosystem.config.ZOMBIE_VISION_RANGE)
    
    for _, potentialTarget in ipairs(entitiesInRange) do
        if potentialTarget.type == "survivor" then
            local distance = entity.position:distance(potentialTarget.position)
            if distance < minDistance then
                minDistance = distance
                nearestTarget = potentialTarget
            end
        end
    end
    
    return nearestTarget
end

function HunterBehavior:isAdjacentTo(entity1, entity2)
    local distance = entity1.position:distance(entity2.position)
    return distance <= 1.5
end

return HunterBehavior