Nido = {}

function Nido:new()
    local newObj = {
        id = id,
        status = status,
        x = x,
        y = y,
        
    }
    self.__index = self
    return setmetatable(newObj, self)
end

