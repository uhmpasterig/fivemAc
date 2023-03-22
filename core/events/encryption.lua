
----------------------------------------------
Encryption = {};
Encryption.__index = Encryption;

function Encryption:Create(key)
  local self = setmetatable({}, Encryption);
  self.key = GetResourceMetadata(GetCurrentResourceName(), 'crypt_key', 0);
  return self;
end

function Encryption:Encrypt(str)
  local result = ""
  local keyIndex = 1
  local key = self.key
  local keyLength = string.len(key)
  for i = 1, string.len(str) do
    local char = string.sub(str, i, i)
    local keyChar = string.sub(key, keyIndex, keyIndex)
    local charCode = string.byte(char)
    local keyCode = string.byte(keyChar)
    local newCharCode = charCode + keyCode
    if newCharCode > 255 then
      newCharCode = newCharCode - 255
    end
    result = result .. string.char(newCharCode)
    keyIndex = keyIndex + 1
    if keyIndex > keyLength then
      keyIndex = 1
    end
  end
  return result
end

function Encryption:Decrypt(str)
  local key = self.key
  local result = ""
  local keyIndex = 1
  local keyLength = string.len(key)
  for i = 1, string.len(str) do
    local char = string.sub(str, i, i)
    local keyChar = string.sub(key, keyIndex, keyIndex)
    local charCode = string.byte(char)
    local keyCode = string.byte(keyChar)
    local newCharCode = charCode - keyCode
    if newCharCode < 0 then
      newCharCode = newCharCode + 255
    end
    result = result .. string.char(newCharCode)
    keyIndex = keyIndex + 1
    if keyIndex > keyLength then
      keyIndex = 1
    end
  end
  return result
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