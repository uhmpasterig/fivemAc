
----------------------------------------------
local cccryptKey = "17SUf7F65grAa2uj2Kj8ng6rLWNah4Y5x6"

Encryption = {};
Encryption.__index = Encryption;

function Encryption:Create(key)
  local self = setmetatable({}, Encryption);
  self.key = cccryptKey;
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