unpack = table.unpack or unpack

posch = {}
posch.events = {}
posch.storage = {}

---calls all event
---@param event string
---@param ... any
function posch.call(event, ...)
    if posch.events[event] then
        for i, func in ipairs(posch.events[event]) do
            func(...)
        end
    end
end

---gets called by event
---@param event string
---@param func function
function posch.on(event, func)
    if not posch.events[event] then
        posch.events[event] = {}
    end
    table.insert(posch.events[event], func)
end

---gets from posch.storage
---@param name string
---@return unknown
function posch.get(name)
    return posch.storage[name]
end

---updates posch.storage
---@param name string
---@param newVar any
function posch.updateStorage(name, newVar)
    posch.storage[name] = newVar
end