local Vector2D = require("src.utils.Vector2D")

local Grid = {}
Grid.__index = Grid

function Grid.new(width, height)
    local self = setmetatable({}, Grid)
    self.width = width
    self.height = height
    self.cells = {}
    for x = 1, width do
        self.cells[x] = {}
        for y = 1, height do
            self.cells[x][y] = {}
        end
    end
    return self
end

function Grid:isValidPosition(position)
    return type(position) == "table" and
           type(position.x) == "number" and
           type(position.y) == "number" and
           position.x >= 1 and position.x <= self.width and
           position.y >= 1 and position.y <= self.height
end

function Grid:getCellIndices(position)
    return math.floor(position.x + 0.5), math.floor(position.y + 0.5)
end

function Grid:addEntity(entity)
    if not entity or not entity.position then
        print("Error: Invalid entity or entity position")
        return false
    end
    
    if self:isValidPosition(entity.position) then
        local xIndex, yIndex = self:getCellIndices(entity.position)
        local cell = self.cells[xIndex][yIndex]
        if cell then
            table.insert(cell, entity)
            return true
        else
            print("Error: Cell does not exist at position", entity.position.x, entity.position.y)
        end
    else
        print("Error: Invalid position for entity", entity.position.x, entity.position.y)
    end
    return false
end

function Grid:removeEntity(entity)
    if not entity or not entity.position then
        print("Error: Invalid entity or entity position")
        return false
    end
    
    if self:isValidPosition(entity.position) then
        local xIndex, yIndex = self:getCellIndices(entity.position)
        local cell = self.cells[xIndex][yIndex]
        if cell then
            for i, e in ipairs(cell) do
                if e == entity then
                    table.remove(cell, i)
                    return true
                end
            end
        else
            print("Error: Cell does not exist at position", entity.position.x, entity.position.y)
        end
    else
        print("Error: Invalid position for entity", entity.position.x, entity.position.y)
    end
    return false
end

function Grid:moveEntity(entity, newPosition)
    if not entity or not newPosition then
        print("Error: Invalid entity or new position")
        return false
    end
    
    if self:isValidPosition(newPosition) then
        local originalPosition = entity.position:clone()
        entity.position = newPosition:clone()
        local addSuccess = self:addEntity(entity)
        
        if addSuccess then
            entity.position = originalPosition
            self:removeEntity(entity)
            entity.position = newPosition
            return true
        else
            entity.position = originalPosition
            print("Error: Failed to add entity to its new position")
        end
    else
        print("Error: Invalid new position for entity", newPosition.x, newPosition.y)
    end
    return false
end

function Grid:getEntitiesInRange(position, range)
    local entities = {}
    local startX = math.max(1, math.floor(position.x - range + 0.5))
    local endX = math.min(self.width, math.floor(position.x + range + 0.5))
    local startY = math.max(1, math.floor(position.y - range + 0.5))
    local endY = math.min(self.height, math.floor(position.y + range + 0.5))

    for x = startX, endX do
        for y = startY, endY do
            local cell = self.cells[x][y]
            for _, entity in ipairs(cell) do
                table.insert(entities, entity)
            end
        end
    end
    return entities
end

return Grid