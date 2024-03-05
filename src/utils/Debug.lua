local Debug = {}

Debug.enabled = false
Debug.logLevel = 3 -- 1=error, 2=warning, 3=info, 4=debug

Debug.ERROR = 1
Debug.WARNING = 2
Debug.INFO = 3
Debug.DEBUG = 4

function Debug.init(enabled, logLevel)
    Debug.enabled = enabled or false
    Debug.logLevel = logLevel or 3
    Debug.log(Debug.INFO, "Debug system initialized. Level: " .. Debug.logLevel)
end

function Debug.log(level, message, ...)
    if not Debug.enabled or level > Debug.logLevel then
        return
    end
    
    local levelNames = {
        [Debug.ERROR] = "ERROR",
        [Debug.WARNING] = "WARNING",
        [Debug.INFO] = "INFO",
        [Debug.DEBUG] = "DEBUG"
    }
    
    local timestamp = os.date("%H:%M:%S")
    local levelString = levelNames[level] or "UNKNOWN"
    local formatted = string.format(message, ...)
    
    print(string.format("[%s] [%s] %s", timestamp, levelString, formatted))
end

function Debug.error(message, ...)
    Debug.log(Debug.ERROR, message, ...)
end

function Debug.warning(message, ...)
    Debug.log(Debug.WARNING, message, ...)
end

function Debug.info(message, ...)
    Debug.log(Debug.INFO, message, ...)
end

function Debug.debug(message, ...)
    Debug.log(Debug.DEBUG, message, ...)
end

function Debug.displayEntityState(entity)
    if not Debug.enabled or Debug.logLevel < Debug.DEBUG then
        return
    end
    
    Debug.debug("Entity: %s, Position: (%.2f, %.2f), Health: %.1f", 
        entity.type, 
        entity.position.x, 
        entity.position.y, 
        entity.health
    )
    
    if entity.type == "survivor" then
        Debug.debug("  Resources: %d, Hunger: %.1f", entity.resources, entity.hunger)
    elseif entity.type == "zombie" then
        Debug.debug("  Infection Power: %d", entity.infectionPower)
    elseif entity.type == "resource" then
        Debug.debug("  Value: %d, Lifespan: %.1f", entity.value, entity.lifespan)
    end
end

function Debug.displayEcosystemStats(ecosystem)
    if not Debug.enabled or Debug.logLevel < Debug.INFO then
        return
    end
    
    local counts = {
        total = #ecosystem.entities,
        zombies = 0,
        survivors = 0,
        resources = 0
    }
    
    for _, entity in ipairs(ecosystem.entities) do
        counts[entity.type .. "s"] = (counts[entity.type .. "s"] or 0) + 1
    end
    
    Debug.info("Ecosystem Stats - Total: %d, Zombies: %d, Survivors: %d, Resources: %d",
        counts.total, counts.zombies, counts.survivors, counts.resources
    )
end

return Debug