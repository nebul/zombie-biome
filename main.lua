local StateManager = require("src.states.StateManager")
local MenuState = require("src.states.MenuState")
local SimulationState = require("src.states.SimulationState")
local Config = require("src.config.Config")
local Debug = require("src.utils.Debug")

local stateManager

function love.load()
    math.randomseed(os.time())

    Debug.init(Config.DEBUG_MODE, Debug.INFO)
    Debug.info("Starting Zombie Biome Simulator")

    love.window.setMode(Config.GRID_WIDTH * Config.CELL_SIZE, Config.GRID_HEIGHT * Config.CELL_SIZE)
    love.graphics.setFont(love.graphics.newFont(Config.MENU_FONT_SIZE))
    
    stateManager = StateManager.new()
    stateManager:addState("menu", MenuState.new(stateManager))
    stateManager:addState("simulation", SimulationState.new(stateManager))
    stateManager:changeState("menu")
    
    Debug.info("Initialization complete")
end

function love.update(dt)
    dt = math.min(dt, 0.1)
    stateManager:update(dt)
end

function love.draw()
    stateManager:draw()
    
    if Config.DEBUG_MODE then
        love.graphics.setColor(1, 1, 0)
        love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 40)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "f3" and love.keyboard.isDown("lctrl") then
        Config.DEBUG_MODE = not Config.DEBUG_MODE
        Debug.init(Config.DEBUG_MODE, Debug.INFO)
        Debug.info("Debug mode: " .. (Config.DEBUG_MODE and "ON" or "OFF"))
    else
        stateManager:keypressed(key)
    end
end

function love.errorhandler(msg)
    Debug.error("LÖVE ERROR: %s", msg)
    
    love.graphics.reset()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("ERROR: " .. tostring(msg), 70, 70, love.graphics.getWidth() - 140)
    
    local trace = debug.traceback()
    local lines = {}
    for line in trace:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    
    local y = 140
    for i = 1, math.min(15, #lines) do
        love.graphics.printf(lines[i], 70, y, love.graphics.getWidth() - 140)
        y = y + 20
    end
    
    love.graphics.present()
    
    return true
end