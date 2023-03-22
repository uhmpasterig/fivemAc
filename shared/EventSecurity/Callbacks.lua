local isServer = IsDuplicityVersion()

callbacks = {}

CORE:Callback = {}
CORE:Callback.__index = CORE:Callback

if isServer then 

  function CORE:Callback:Register(name, routine)
    callbacks[name] = routine
  end 

  function CORE:Callback:Exec(name, source, ...)
    if not callbacks[name] then return "Callback " .. name .. " not found" end
    return callbacks[name](source,...)
  end

  RegisterNetEvent("CORE:callback:trigger", function(name, id, ...)
    local r = CORE:Callback:Exec(name, source, ...)
    TriggerClientEvent("CORE:callback:response", source, id, r)
  end)

else

  function CORE:Callback:GetId()
    local id = math.random(1, 9999999) 
    while callbacks[id] do
      id = math.random(1, 9999999)
      Wait(10)
    end
    return id
  end

  function CORE:Callback:Trigger(name, cb, ...)
    local id = CORE:Callback:GetId()
    callbacks[id] = cb
    TriggerServerEvent("CORE:trigger", name, id, ...)
  end

  RegisterNetEvent("CORE:callback:response", function(id, r)
    callbacks[id](table.unpack(r))
    callbacks[id] = nil
  end)
  
end

----------------------------------------------

EventController = {};

local isServer = IsDuplicityVersion();

local encryption = Encryption:Create();

----------------------------------------------

function EventController:Register(eventName, routine)
  local encryptedName = encryption:Encrypt(eventName);
  RNE(encryptedName)
  if routine then 
    EventController:Listen(eventName, routine);
  end
end

function EventController:Listen(eventName, routine)
  local encryptedName = encryption:Encrypt(eventName);
  local _routine = routine
  routine = function(data)
    local args = json.decode(encryption:Decrypt(data))
    _routine(table.unpack(args));
  end
  AEH(encryptedName, routine);
end

----------------------------------------------

function EventController:TriggerEvent(eventName, args, isNet, spare)
  if spare == false and isServer then
    id = args;
    args = isNet;
    isNet = spare;
  end
  
  eventName = encryption:Encrypt(eventName);
  local data = encryption:Encrypt(args);
 
  if isNet then 
    TE(eventName, data);
    return
  end;
  if isServer then
    TCE(eventName, id, data);
    return 
  end
  TSE(eventName, data);
end

----------------------------------------------

----------------------------------------------

RNE  =  RegisterNetEvent;
RSE  =  RegisterServerEvent;
RCE  =  RegisterClientEvent;
AEH  =  AddEventHandler;
TCE  =  TriggerClientEvent;
TSE  =  TriggerServerEvent;
TE   =  TriggerEvent;

----------------------------------------------

RegisterNetEvent = function(eventName, routine)
  EventController:Register(eventName, routine);
end 

RegisterServerEvent = function(eventName, routine)
  EventController:Register(eventName, routine);
end

RegisterClientEvent = function(eventName, routine)
  EventController:Register(eventName, routine);
end 

AddEventHandler = function(eventName, routine)
  EventController:Listen(eventName, routine);
end 

TriggerEvent = function(eventName, ...)
  EventController:TriggerEvent(eventName, json.encode({...}), true);
end

TriggerClientEvent = function(eventName, id, ...)
  EventController:TriggerEvent(eventName, id, json.encode({...}), false);
end

TriggerServerEvent = function(eventName, ...)
  EventController:TriggerEvent(eventName, json.encode({...}), false);
end
