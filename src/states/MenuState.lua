local MenuState = {}
MenuState.__index = MenuState

function MenuState.new(stateManager)
    return setmetatable({
        stateManager = stateManager,
        menuItems = {"Start Simulation", "Options", "Quit"},
        selectedItem = 1
    }, MenuState)
end

function MenuState:enter()
    love.keyboard.setKeyRepeat(true)
end

function MenuState:exit()
    love.keyboard.setKeyRepeat(false)
end

function MenuState:update(dt)
end

function MenuState:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Zombie Biome Simulator", 0, 100, love.graphics.getWidth(), "center")
    
    for i, item in ipairs(self.menuItems) do
        if i == self.selectedItem then
            love.graphics.setColor(1, 1, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.printf(item, 0, 200 + i * 40, love.graphics.getWidth(), "center")
    end
end

function MenuState:keypressed(key)
    if key == "up" then
        self.selectedItem = math.max(1, self.selectedItem - 1)
    elseif key == "down" then
        self.selectedItem = math.min(#self.menuItems, self.selectedItem + 1)
    elseif key == "return" then
        if self.menuItems[self.selectedItem] == "Start Simulation" then
            self.stateManager:changeState("simulation")
        elseif self.menuItems[self.selectedItem] == "Quit" then
            love.event.quit()
        end
    end
end

return MenuState