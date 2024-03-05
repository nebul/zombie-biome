local Vector2D = require("src.utils.Vector2D")

local MovementBehavior = {}
MovementBehavior.__index = MovementBehavior

function MovementBehavior.new()
    return setmetatable({}, MovementBehavior)
end

function MovementBehavior:move(entity, direction, speed, dt, ecosystem)
    if not entity or not direction or not speed or not dt or not ecosystem then
        print("Error: Invalid parameters for move")
        return
    end

    local normalizedDirection = direction:clone():normalize()
    
    local displacement = normalizedDirection:clone():multiply(speed * dt)
    
    local nextPosition = Vector2D.new(
        entity.position.x + displacement.x,
        entity.position.y + displacement.y
    )

    nextPosition.x = math.max(1, math.min(nextPosition.x, ecosystem.config.GRID_WIDTH))
    nextPosition.y = math.max(1, math.min(nextPosition.y, ecosystem.config.GRID_HEIGHT))

    if not ecosystem:moveEntity(entity, nextPosition) then
        print("Failed to move entity", entity, "to position", nextPosition.x, nextPosition.y)
    end
end

function MovementBehavior:wander(entity, speed, dt, ecosystem)
    if not entity or not speed or not dt or not ecosystem then
        print("Error: Invalid parameters for wander")
        return
    end

    local directions = {
        Vector2D.new(1, 0),   -- right
        Vector2D.new(-1, 0),  -- left
        Vector2D.new(0, 1),   -- down
        Vector2D.new(0, -1),  -- up
        Vector2D.new(1, 1),   -- down-right
        Vector2D.new(1, -1),  -- up-right
        Vector2D.new(-1, 1),  -- down-left
        Vector2D.new(-1, -1)  -- up-left
    }
    
    local randomDirection = directions[math.random(#directions)]
    self:move(entity, randomDirection, speed, dt, ecosystem)
end

return MovementBehavior