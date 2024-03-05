local Config = require("src.config.Config")

function love.conf(t)
    t.title = "Zombie Biome Simulator"
    t.version = "11.5"
    t.window.width = Config.GRID_WIDTH * Config.CELL_SIZE
    t.window.height = Config.GRID_HEIGHT * Config.CELL_SIZE
    t.window.resizable = false
    t.window.vsync = 1
    t.modules.joystick = false
    t.modules.physics = false
    t.console = true
end