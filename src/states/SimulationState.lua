local Ecosystem = require("src.core.Ecosystem")
local Config = require("src.config.Config")

local SimulationState = {}
SimulationState.__index = SimulationState

function SimulationState.new(stateManager)
    return setmetatable({
        stateManager = stateManager,
        ecosystem = Ecosystem.new(),
        cellSize = 0
    }, SimulationState)
end

function SimulationState:enter()
    self.ecosystem:initialize()
    self.cellSize = math.min(
        love.graphics.getWidth() / Config.GRID_WIDTH, 
        love.graphics.getHeight() / Config.GRID_HEIGHT
    )
    self.elapsedTime = 0
end

function SimulationState:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.elapsedTime >= Config.MAX_SIMULATION_TIME then
        self.stateManager:changeState("menu")
    else
        self.ecosystem:update(dt)
    end
end

function SimulationState:draw()
    for _, entity in ipairs(self.ecosystem.entities) do
        local x = (entity.position.x - 1) * self.cellSize
        local y = (entity.position.y - 1) * self.cellSize
        if entity.type == "zombie" then
            love.graphics.setColor(1, 0, 0)
        elseif entity.type == "survivor" then
            love.graphics.setColor(0, 1, 0)
        elseif entity.type == "resource" then
            love.graphics.setColor(1, 1, 0)
        end
        love.graphics.rectangle("fill", x, y, self.cellSize, self.cellSize)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Entities: " .. #self.ecosystem.entities, 10, 10)
end

function SimulationState:keypressed(key)
    if key == "escape" then
        self.stateManager:changeState("menu")
    end
end

return SimulationState