local Config = {
    DEBUG_MODE = false,

    -- Grid settings
    GRID_WIDTH = 50,
    GRID_HEIGHT = 30,

    -- Entity limits
    MAX_ENTITIES = 1000,
    INITIAL_ZOMBIES = 5,
    INITIAL_SURVIVORS = 10,

    -- Simulation settings
    UPDATE_INTERVAL = 1, -- seconds
    MAX_SIMULATION_TIME = 300, -- seconds

    -- Entity properties
    ZOMBIE_SPEED = 1,
    SURVIVOR_SPEED = 2,
    INFECTION_CHANCE = 0.3,
    RESOURCE_SPAWN_RATE = 0.05,
    HUNGER_RATE = 1,
    HEALTH_DECREMENT_RATE = 5,
    
    -- Vision ranges
    SURVIVOR_VISION_RANGE = 5,
    ZOMBIE_VISION_RANGE = 4,

    -- Resource settings
    RESOURCE_MIN_VALUE = 20,
    RESOURCE_MAX_VALUE = 60,

    -- UI settings
    CELL_SIZE = 20,
    MENU_FONT_SIZE = 24,


}

return Config