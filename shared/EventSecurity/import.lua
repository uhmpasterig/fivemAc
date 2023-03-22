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