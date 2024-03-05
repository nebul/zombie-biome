local Observable = {}
Observable.__index = Observable

function Observable.new()
    return setmetatable({observers = {}}, Observable)
end

function Observable:addObserver(event, callback)
    self.observers[event] = self.observers[event] or {}
    table.insert(self.observers[event], callback)
end

function Observable:removeObserver(event, callback)
    if self.observers[event] then
        for i, obs in ipairs(self.observers[event]) do
            if obs == callback then
                table.remove(self.observers[event], i)
                break
            end
        end
    end
end

function Observable:notify(event, ...)
    if self.observers[event] then
        for _, callback in ipairs(self.observers[event]) do
            callback(...)
        end
    end
end

return Observable