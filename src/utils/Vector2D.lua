local Vector2D = {}
Vector2D.__index = Vector2D

function Vector2D.new(x, y)
    return setmetatable({x = x or 0, y = y or 0}, Vector2D)
end

function Vector2D:clone()
    return Vector2D.new(self.x, self.y)
end

function Vector2D:magnitude()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector2D:normalize()
    local mag = self:magnitude()
    if mag > 0 then
        self.x = self.x / mag
        self.y = self.y / mag
    end
    return self
end

function Vector2D:add(other)
    self.x = self.x + other.x
    self.y = self.y + other.y
    return self
end

function Vector2D:subtract(other)
    self.x = self.x - other.x
    self.y = self.y - other.y
    return self
end

function Vector2D:multiply(scalar)
    self.x = self.x * scalar
    self.y = self.y * scalar
    return self
end

function Vector2D:divide(scalar)
    if scalar ~= 0 then
        self.x = self.x / scalar
        self.y = self.y / scalar
    end
    return self
end

function Vector2D:dot(other)
    return self.x * other.x + self.y * other.y
end

function Vector2D:distance(other)
    local dx = self.x - other.x
    local dy = self.y - other.y
    return math.sqrt(dx * dx + dy * dy)
end

return Vector2D
