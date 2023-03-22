----------------------------------------------
local isServer = IsDuplicityVersion();

callbacks = {}

Callback = {}
Callback.__index = Callback

if isServer then 

  function Callback:Register(name, routine)
    callbacks[name] = routine
  end 

  function Callback:Exec(name, source, ...)
    if not callbacks[name] then return "Callback " .. name .. " not found" end
    local res = callbacks[name](source,...)
    return res
  end

  RegisterNetEvent("zero_eventsecurity:callback:trigger", function(name, id, ...)
    local r = Callback:Exec(name, source, ...)
    TriggerClientEvent("zero_eventsecurity:callback:response", source, id, r)
  end)

else

  function Callback:GetId()
    local id = math.random(1, 9999999) 
    while callbacks[id] do
      id = math.random(1, 9999999)
      Wait(10)
    end
    return id
  end

  function Callback:Trigger(name, cb, ...)
    if not callbacks[name] then return "Callback " .. name .. " not found" end
    local id = Callback:GetId()
    callbacks[id] = cb
    TriggerServerEvent("zero_eventsecurity:callback:trigger", name, id, ...)
  end

  RegisterNetEvent("zero_eventsecurity:callback:response", function(id, r)
    callbacks[id](table.unpack(r))
    callbacks[id] = nil
  end)
  
end

RegisterServerCallback = function(name, routine)
  Callback:Register(name, routine)
end

TriggerServerCallback = function(name, cb, ...)
  Callback:Trigger(name, cb, ...)
end

----------------------------------------------